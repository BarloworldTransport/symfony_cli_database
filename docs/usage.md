# Usage

## Config
- cli.ini
  - create config directory directly under project directory
  - create config/cli.ini
  - populate cli.ini with your details
    ```
     [database]
     host={host}
     user={user}
     password={password}
     schema={schema}
    ```

## Usage Examples
- Basic example
  - console Query:Select 'select * from `table` order by id desc limit ?' /tmp/output.csv 1
  - console Query:Select 'select * from `table` order by id desc limit 1' /tmp/output.csv --- I do not recommend this usage. Binding values is always a better approach
  - console Query:Select /tmp/syspro.sql /tmp/syspro.csv 417031 424483 423751 421979