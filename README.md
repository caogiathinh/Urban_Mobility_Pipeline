# Urban_Mobility_Pipeline: Nền tảng Dữ liệu Hiện đại cho Phân tích Vận tải Đô thị

**Trạng thái dự án:** 🚧 **Đang triển khai (In Progress)** 🚧

Dự án này nhằm xây dựng một nền tảng dữ liệu end-to-end, có khả năng mở rộng và tự động hóa, để giải quyết các bài toán phân tích nghiệp vụ và hỗ trợ ra quyết định trong lĩnh vực vận tải đô thị.

---

## 1. Bối cảnh & Thách thức (The Problem)

Ngành vận tải đô thị tại New York đang phải đối mặt với những thách thức phức tạp, ảnh hưởng đến cả nhà quản lý (TLC), tài xế và hành khách:
* **Tắc nghẽn nghiêm trọng:** Một người dân New York mất trung bình **117 giờ mỗi năm** vì kẹt xe, làm giảm hiệu suất của tài xế và ảnh hưởng trực tiếp đến hành khách.
* **Thay đổi mô hình nhu cầu (Hậu COVID-19):** Mô hình làm việc hybrid/remote đã làm thay đổi các "điểm nóng" và "giờ cao điểm" truyền thống, khiến các mô hình dự báo cũ trở nên kém hiệu quả.
* **Cạnh tranh khốc liệt từ Xe Công nghệ (FHVs):** Sự trỗi dậy của Uber, Lyft đã phá vỡ thị trường taxi truyền thống, đặt ra yêu cầu cấp thiết về việc tối ưu hóa vận hành.

**Vấn đề cốt lõi:** Sự thiếu hụt một nền tảng dữ liệu tập trung, mạnh mẽ đã khiến các bên liên quan hoạt động với thông tin rời rạc, dẫn đến hạn chế khả năng ra quyết định.

---

## 2. Giải pháp & Mục tiêu (The Solution)

Dự án này sẽ triển khai một **nền tảng dữ liệu hiện đại (Modern Data Platform)** với các mục tiêu chính:

* **Về mặt Kỹ thuật:**
  1. Xây dựng một đường ống dữ liệu (Data Pipeline) hoàn chỉnh và tự động.
  2. Đảm bảo chất lượng dữ liệu thông qua các bài kiểm thử tự động.
  3. Thiết kế hệ thống có khả năng mở rộng và dễ bảo trì.

* **Về mặt Nghiệp vụ:**
  1. Tối ưu hóa Vận hành qua phân tích nhu cầu thị trường.
  2. Xây dựng Hệ thống Đo lường Hiệu suất Kinh doanh (KPIs).
  3. Cung cấp năng lực phân tích dữ liệu để hỗ trợ TLC ra quyết định.

---

## 3. Kiến trúc hệ thống (System Architecture)

<p align="center">
  <img src="https://github.com/caogiathinh/End-to-End-Cloud-Data-Platform/blob/main/images/DataArchitecture.png" alt="Sơ đồ kiến-trúc" width="800">
</p>
Dự án áp dụng kiến trúc **ELT (Extract - Load - Transform)** trên nền tảng cloud, với các thành phần được container hóa để đảm bảo tính nhất quán và khả năng mở rộng.

### Tech Stack

| Tầng (Layer)          | Công nghệ                                                               | Vai trò                                                                                   |
| --------------------- | ----------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------|
| **Containerization**  | <img src="https://img.shields.io/badge/Docker-2496ED?logo=docker" />    | Đóng gói ứng dụng và phụ thuộc, đảm bảo môi trường nhất quán từ local đến production      |
| **Infrastructure**    | <img src="https://img.shields.io/badge/Terraform-7B42BC?logo=terraform" /> | Quản lý hạ tầng dưới dạng mã (Infrastructure as Code), tự động tạo tài nguyên cloud      |
| **Data Lake**         | <img src="https://img.shields.io/badge/Google_Cloud_Storage-4285F4?logo=google-cloud" /> | Lưu trữ dữ liệu thô (raw data) với chi phí thấp và khả năng mở rộng cao                  |
| **Data Warehouse**    | <img src="https://img.shields.io/badge/Google_BigQuery-669DF6?logo=google-bigquery" /> | Kho dữ liệu serverless, hiệu năng cao, tối ưu cho các truy vấn phân tích                 |
| **Transformation**    | <img src="https://img.shields.io/badge/Apache_Spark-E25A1C?logo=apache-spark" /> <img src="https://img.shields.io/badge/dbt-FF694B?logo=dbt" /> | **Spark:** Xử lý dữ liệu lớn, **dbt:** Quản lý transformation và kiểm thử dữ liệu       |
| **Data Orchestration**| <img src="https://img.shields.io/badge/Kestra-E157F8" />                 | "Nhạc trưởng" điều phối, lập lịch và giám sát toàn bộ pipeline dữ liệu                   |
| **Data Testing**      | <img src="https://img.shields.io/badge/dbt-FF694B?logo=dbt" />           | Tích hợp kiểm thử chất lượng dữ liệu (schema, referential integrity, business logic)      |
| **Data Visualization**| <img src="https://img.shields.io/badge/Looker_Studio-4285F4?logo=looker" /> | Xây dựng các báo cáo và dashboard tương tác để phục vụ người dùng cuối                  |

---

## 4. Mô hình Dữ liệu (Data Model)

Hệ thống sẽ triển khai mô hình **Star Schema** trong Data Warehouse (BigQuery) để tối ưu cho các truy vấn phân tích. Mô hình bao gồm một bảng Fact trung tâm (`fct_trip`) và các bảng Dimension liên quan (`dim_driver`, `dim_location`, ...).

Thiết kế này sẽ được tối ưu hiệu năng bằng cách **Partition** bảng Fact theo ngày và **Cluster** theo các cột thường được lọc.

---

## 5. Lộ trình Triển khai (Implementation Roadmap)

Dự án sẽ được triển khai theo các giai đoạn chính, tương ứng với việc xây dựng từng phần của kiến trúc:

* [ ] **Giai đoạn 1: Foundation & Infrastructure (Tuần 1)**
    * [ ] Thiết lập môi trường phát triển local với Docker & PostgreSQL.
    * [ ] Viết script ingest dữ liệu ban đầu.
    * [ ] Dùng Terraform để tự động hóa việc tạo GCS bucket và BigQuery dataset.
* [ ] **Giai đoạn 2: Orchestration & Cloud DWH (Tuần 2)**
    * [ ] Cài đặt và cấu hình Kestra.
    * [ ] Xây dựng pipeline ELT tự động từ nguồn dữ liệu -> GCS -> BigQuery.
    * [ ] Tối ưu hóa bảng trong BigQuery với Partitioning và Clustering.
* [ ] **Giai đoạn 3: Analytics Engineering (Tuần 3)**
    * [ ] Thiết lập project dbt.
    * [ ] Xây dựng các data model (staging, core) theo Star Schema.
    * [ ] Triển khai các bài kiểm thử dữ liệu (data tests) để đảm bảo chất lượng.
* [ ] **Giai đoạn 4: Batch Processing & Visualization (Tuần 4)**
    * [ ] Sử dụng Spark để xử lý các tác vụ biến đổi dữ liệu phức tạp.
    * [ ] Xây dựng các dashboard phân tích ban đầu trên Looker Studio.
    * [ ] Tổng kết dự án và hoàn thiện tài liệu.

---

## 6. License

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

## 7. Đóng góp

Mọi đóng góp đều được hoan nghênh! Vui lòng mở issue hoặc pull request trên GitHub để thảo luận và đóng góp cho dự án.

---
