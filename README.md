# Dino Management System

This program analyzes dinosaur population data and calculates health metrics, providing detailed reports and a population summary.

## Getting Started

To run this project, you'll need Ruby installed on your system.

### Installation

1.  Clone the repository:
    ```bash
    git clone https://github.com/bryanprz/corporate_tools.git
    cd corporate_tools
    ```

## How to Run the Program

To run the full analysis with sample data and see the formatted output in your terminal, execute the following command from the project's root directory:

```bash
ruby run_app.rb
```

## How to Run the Tests

This project uses RSpec for testing.

To run all tests:

```bash
rspec
```

To run specific test files:

*   **Integration Test (Public API):**
    ```bash
    rspec spec/dino_management_spec.rb
    ```

*   **Unit Tests:**
    ```bash
    rspec spec/dino_spec.rb
    rspec spec/dino_analysis_report_spec.rb
    rspec spec/dino_analyzer_spec.rb
    ```
