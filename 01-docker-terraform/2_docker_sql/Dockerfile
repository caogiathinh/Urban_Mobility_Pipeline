# image Docker cơ sở mà chúng ta sẽ xây dựng trên đó

FROM python:3.9.1

# thiết lập image của chúng ta bằng cách cài đặt các điều kiện tiên quyết; pandas trong trường hợp này
RUN apt-get install wget

RUN pip install pandas sqlalchemy psycopg2-binary pyarrow

# thiết lập thư mục làm việc bên trong container
WORKDIR /app

# sao chép script vào container. Tên đầu tiên là tệp nguồn, thứ hai là đích
COPY ingest_data.py ingest_data.py

# định nghĩa điều gì sẽ làm đầu tiên khi container chạy
ENTRYPOINT ["python", "ingest_data.py"]