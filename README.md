# Urban_Mobility_Pipeline: Đường ống Dữ liệu cho Phân tích Vận tải Đô thị

**Trạng thái dự án:** 🚧 Đang triển khai (In Progress) 🚧

Dự án này xây dựng một nền tảng dữ liệu end-to-end, có khả năng mở rộng và tự động hóa, để giải quyết các bài toán phân tích nghiệp vụ và hỗ trợ ra quyết định trong lĩnh vực vận tải đô thị.

---

## 1. Bối cảnh & Thách thức (The Problem)

Ngành vận tải đô thị tại New York đối mặt với nhiều thách thức:
- **Tắc nghẽn giao thông:** 117 giờ/năm/người.
- **Thay đổi mô hình nhu cầu (Hậu COVID-19):** Di chuyển không còn tập trung vào giờ cao điểm truyền thống.
- **Cạnh tranh từ Xe Công nghệ (Uber, Lyft):** Cần tối ưu hóa vận hành và phân tích cạnh tranh.

**Vấn đề cốt lõi:** Thiếu một nền tảng dữ liệu tập trung, mạnh mẽ cho các bên liên quan.

---

## 2. Giải pháp & Mục tiêu (The Solution)

### Mục tiêu Kỹ thuật
1. Xây dựng đường ống dữ liệu (Data Pipeline) hoàn chỉnh và tự động.
2. Đảm bảo chất lượng dữ liệu qua kiểm thử tự động.
3. Thiết kế hệ thống mở rộng, dễ bảo trì.

### Mục tiêu Nghiệp vụ
1. Tối ưu vận hành qua phân tích nhu cầu thị trường.
2. Xây dựng hệ thống đo lường hiệu suất (KPIs).
3. Cung cấp năng lực phân tích hỗ trợ ra quyết định.

---

## 3. Kiến trúc hệ thống (System Architecture)

![Kiến trúc tổng quan](https://github.com/caogiathinh/End-to-End-Cloud-Data-Platform/blob/main/images/DataArchitecture.png)

Áp dụng kiến trúc ELT (Extract - Load - Transform) trên nền tảng cloud, container hóa từng thành phần để đảm bảo tính nhất quán và khả năng mở rộng.

### Tech Stack

| Layer                  | Technology | Vai trò |
|------------------------|------------|---------|
| **Containerization**   | Docker     | Đóng gói ứng dụng, môi trường nhất quán |
| **Infrastructure**     | Terraform  | Quản lý hạ tầng dưới dạng mã (IaC) |
| **Data Lake**          | Google Cloud Storage | Lưu trữ dữ liệu thô |
| **Data Warehouse**     | BigQuery   | Lưu trữ & truy vấn dữ liệu phân tích |
| **Transformation**     | dbt, Spark | Chuyển đổi, chuẩn hóa dữ liệu |
| **Orchestration**      | Kestra     | Điều phối, lên lịch pipeline dữ liệu |
| **Testing**            | dbt        | Kiểm thử chất lượng dữ liệu |
| **Visualization**      | Looker Studio | Báo cáo, dashboard phân tích |

---

## 4. Cấu trúc thư mục (File Structure)

```
├── 01-docker-terraform/
│   ├── 1_terraform_gcp/        # IaC scripts for GCP (main.tf, variables.tf)
│   └── 2_docker_sql/           # Docker setup for SQL ingest (Dockerfile, ingest_data.py)
├── 02-workflow-orchestration/  # Workflow orchestration (e.g., Kestra flows)
├── 03-data-warehouse/          # BigQuery schemas, warehouse logic
├── 04-analytics-engineering/
│   └── taxi_rides_ny/          # dbt project for analytics engineering
├── docs/                       # Documentation
├── .github/                    # GitHub workflows, issue templates
├── .vscode/                    # Editor config
└── README.md                   # Main project documentation
```

---

## 5. Thành phần chính (Main Modules)

### Data Ingestion
- **Python scripts** (e.g., ingest_data.py): Tải dữ liệu nguồn về, làm sạch và chuẩn hóa.
- **Docker**: Đóng gói quy trình ingest, đảm bảo dễ triển khai ở nhiều môi trường.
  ```dockerfile
  FROM python:3.9.1
  RUN pip install pandas sqlalchemy psycopg2-binary pyarrow
  WORKDIR /app
  COPY ingest_data.py ingest_data.py
  ENTRYPOINT ["python", "ingest_data.py"]
  ```

### Infrastructure as Code
- **Terraform scripts**: Tự động hóa tạo bucket GCS, BigQuery dataset, resource lifecycle.
  ```hcl
  resource "google_storage_bucket" "demo-bucket" {...}
  resource "google_bigquery_dataset" "demo_dataset" {...}
  ```

### Workflow Orchestration
- **Kestra**: Điều phối pipeline, lên lịch các job ingest, transform, load.

### Data Warehouse & Analytics
- **dbt**: Quản lý schema, transformation và testing cho phân tích nghiệp vụ.
- **Jupyter Notebooks**: Khám phá, trực quan hóa dữ liệu, kiểm thử ý tưởng.

---

## 6. Mô hình Dữ liệu (Data Model)

- Sử dụng **Star Schema** trong BigQuery: Bảng Fact (`fct_trip`) và Dimension (e.g., `dim_driver`, `dim_location`).
- Partition bảng Fact theo ngày, cluster theo các cột lọc phổ biến.

---

## 7. Hướng dẫn cài đặt & triển khai (Setup & Deployment)

### Prerequisites
- Python 3.8+
- Docker
- Terraform
- dbt
- Google Cloud SDK

### Steps

```bash
# Clone repo
git clone https://github.com/caogiathinh/Urban_Mobility_Pipeline.git
cd Urban_Mobility_Pipeline

# Setup Python environment
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Build Docker containers
cd 01-docker-terraform/2_docker_sql
docker build -t taxi-ingest .

# Terraform: Setup GCP resources
cd ../1_terraform_gcp
terraform init
terraform apply

# dbt: Run analytics engineering
cd ../../04-analytics-engineering/taxi_rides_ny
dbt seed
dbt run
dbt test
```

---

## 8. Cấu hình (Configuration)

- Sử dụng `.env` cho credentials, secrets.
- Sửa các biến trong Terraform (`variables.tf`), dbt (`dbt_project.yml`).
- Dockerfile có thể chỉnh sửa để bổ sung thư viện hoặc script ingest.

---

## 9. Quy trình phát triển & đóng góp (Contributing)

Mọi đóng góp đều được hoan nghênh!
1. Fork repository và tạo nhánh mới (`git checkout -b feature-xyz`)
2. Commit và mở Pull Request mô tả rõ tính năng/sửa lỗi.
3. Ưu tiên code chuẩn PEP8, có docstring và kiểm thử tự động.

---

## 10. Lộ trình triển khai (Implementation Roadmap)

- Giai đoạn 1: Foundation & Infrastructure (Docker, Terraform, PostgreSQL)
- Giai đoạn 2: Orchestration & Cloud DWH (Kestra, BigQuery)
- Giai đoạn 3: Analytics Engineering (dbt, Star Schema, data tests)
- Giai đoạn 4: Batch Processing & Visualization (Spark, Looker Studio)

---

## 11. License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.

```
MIT License

Copyright (c) 2025 caogiathinh

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

---

## 12. Liên hệ (Contact)

- Mở Issue hoặc Pull Request trên [GitHub](https://github.com/caogiathinh/Urban_Mobility_Pipeline/issues)
- Chủ dự án: [@caogiathinh](https://github.com/caogiathinh)

---

## 13. Tài liệu & Tham khảo

- [dbt Docs](https://docs.getdbt.com/docs/introduction)
- [Terraform Docs](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [Docker Docs](https://docs.docker.com/)
- [Kestra Docs](https://kestra.io/docs/)
