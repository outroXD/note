# Docker
# Tips
## MySQL5.7のコンテナを作成し、docker-composeで立ち上げる時`chown: changing ownership of '<ファイル名>': Operation not permitted`
### 症状

```Dockerfile:Dockerfile
FROM mysql:5.7
RUN touch /var/log/mysql/mysqld.log

ADD ./cnf/my.cnf /etc/mysql/my.cnf
RUN chmod 644 /etc/mysql/my.cnf
```

```yaml:docker-compose.yml
version: '3'
services:
  work-atled-mysql:
    build: .
    image: mysql:5.7
    container_name: work-atled-mysql
    environment:
    - MYSQL_ROOT_PASSWORD=agileworks
    ports:
    - 3306:3306
    volumes:
    - ./data2:/var/lib/mysql
    - ./sql:/docker-entrypoint-initdb.d
```

* 初回`docker-compose build/up`時は問題なくコンテナが立ち上がるが、一度コンテナを落として暫くしてから再度立ち上げようとすると、下記のようなエラーでコンテナが立ち上がらない。

<details>
<summary>work-atled-mysql    | 2021-01-13 06:23:01+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 5.7.32-1debian10 started.</summary>
<div>
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/._agileworks': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/._agileworks_user': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/._auto.cnf': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/._ca-key.pem': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/._ca.pem': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/._client-cert.pem': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/._client-key.pem': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/._ib_buffer_pool': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/._ib_logfile0': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/._ib_logfile1': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/._ibdata1': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/._mysql': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/._performance_schema': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/._private_key.pem': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/._public_key.pem': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/._server-cert.pem': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/._server-key.pem': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/._sys': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/agileworks/._access_con.frm': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/agileworks/._access_con.ibd': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/agileworks/._access_con_doc_entry.frm': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/agileworks/._access_con_doc_entry.ibd': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/agileworks/._apldoc_cond.frm': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/agileworks/._apldoc_cond.ibd': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/agileworks/._apldoc_field.frm': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/agileworks/._apldoc_field.ibd': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/agileworks/._arc_cond.frm': Operation not permitted  
work-atled-mysql    | chown: changing ownership of '/var/lib/mysql/agileworks/._arc_cond.ibd': Operation not permitted  
<略>
</div>
</details>

### 解決方法
```Dockerfile:Dockerfile
FROM mysql:5.7
RUN touch /var/log/mysql/mysqld.log

ADD ./cnf/my.cnf /etc/mysql/my.cnf
RUN chmod 644 /etc/mysql/my.cnf

USER mysql
```

ホストとコンテナ内での実行時のユーザーとそれに付与されている権限あたりが問題と見て、実行時ユーザーをmysqlとしたら消えた。。  
対応方法に全く自信がないので、後々調べて体系化する。