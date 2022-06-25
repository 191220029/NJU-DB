#include<iostream>
#include<mysql.h>
#include<string>
//#pragma comment(lib, "D:\\mysql\\mysql-8.0.26-winx64\\lib\\libmysql.lib")
using namespace std;

void sol_4(MYSQL &myConnect, MYSQL_RES* result, int res, MYSQL_ROW &sql_row) {
    mysql_query(&myConnect, "SET NAMES GBK"); //设置编码格式
        //mysql_query(&myConnect, "use orderdb");
    char fence_begin[] = "=================result of %d_(%d)===============================\n";
    char fence_end[] = "===============================================================\n";
    //4.1
    {
        printf(fence_begin, 4, 1);
        char order_4_1[] = "select employeeNo, employeeName, salary \
                            from employee \
                            order by salary desc\
                            limit 20";
        res = mysql_query(&myConnect, order_4_1);
        if (!res)
        {
            result = mysql_store_result(&myConnect);
            if (result)
            {
                int num_fields = mysql_num_fields(result);
                MYSQL_FIELD* field;
                char space[] = "                    ";
                while (field = mysql_fetch_field(result)) {
                    char s[128];
                    sprintf(s, "%s%s", field->name, space);
                    printf("%-20.20s", s);
                }
                cout << endl;
                while (sql_row = mysql_fetch_row(result))//获取具体的数据
                {
                    for (int i = 0; i < num_fields; i++) {
                        char s[128];
                        sprintf(s, "%s%s", sql_row[i], space);
                        printf("%-20.20s", s);
                    }
                    cout << endl;
                }
            }
        }
        else
        {
            cout << "query sql failed!" << endl;
        }
        printf(fence_end);
    }
    //4.2
    {
        char order_4_2[] = "insert into customer (customerNo, customerName, address, telephone, zip) values ('C20080002', '泰康股份有限公司', '天津市', '010-5422685', '220501')";
        printf(fence_begin, 4, 2);
        res = mysql_query(&myConnect, order_4_2);
        if (!res)
        {
            cout << "query sql '" << order_4_2 << "' succeeded!" << endl;;
        }
        else
        {
            cout << "query sql failed!" << endl;
        }
        printf(fence_end);
    }
    //4.3
    {
        char order_4_3[5][128] = { "SET FOREIGN_KEY_CHECKS = 0",
                            "SET SQL_SAFE_UPDATES = 0",
                            "delete from employee where salary > 5000",
                            "SET SQL_SAFE_UPDATES = 1;",
                            "SET FOREIGN_KEY_CHECKS = 1" };
        printf(fence_begin, 4, 3);
        for (int i = 0; i < 5; i++) {
            res = mysql_query(&myConnect, order_4_3[i]);
            if (!res)
            {
                cout << "query sql '" << order_4_3[i] << " 'succeeded!" << endl;;
            }
            else
            {
                cout << "query sql'" << order_4_3[i] << " ' failed!" << endl;
                break;
            }
        }

        printf(fence_end);
    }
    //4.4
    {
        char order_4_3[3][128] = { "SET SQL_SAFE_UPDATES = 0",
                                "update product set productPrice = productPrice * 0.5 where productPrice > 1000",
                                "SET SQL_SAFE_UPDATES = 1" };
        printf(fence_begin, 4, 4);
        for (int i = 0; i < 3; i++) {
            res = mysql_query(&myConnect, order_4_3[i]);
            if (!res)
            {
                cout << "query sql '" << order_4_3[i] << " 'succeeded!" << endl;;
            }
            else
            {
                cout << "query sql'" << order_4_3[i] << " ' failed!" << endl;
                break;
            }
        }

        printf(fence_end);
    }
    return;
}

void sol_5(MYSQL& myConnect, MYSQL_RES* result, int res, MYSQL_ROW& sql_row) {
    mysql_query(&myConnect, "SET NAMES GBK"); //设置编码格式
        //mysql_query(&myConnect, "use orderdb");
    char fence_begin[] = "=================result of %d_(%d)===============================\n";
    char fence_end[] = "===============================================================\n";
    
    //5.1
    {
        char order_5_1[6][128] = { "SET SQL_SAFE_UPDATES = 0",
                                "set @sql = \"update employee set salary = salary + 200 where department = '",
                                "PREPARE stmt FROM @sql",
                                "EXECUTE stmt",
                                "deallocate prepare stmt",
                                "SET SQL_SAFE_UPDATES = 1" };
        char department[128];
        cout << "Please input department Name:";
        cin >> department;
        strcat(department, "'\"");
        strcat(order_5_1[1], department);
        printf(fence_begin, 5, 1);
        for (int i = 0; i < 6; i++) {
            res = mysql_query(&myConnect, order_5_1[i]);
            if (!res)
            {
                cout << "query sql '" << order_5_1[i] << " 'succeeded!" << endl;;
            }
            else
            {
                cout << "query sql'" << order_5_1[i] << " ' failed!" << endl;
                break;
            }
        }

        printf(fence_end);
    }
    //5.2
    
    {
        char order_5_2[1][128] = { "select customerName, address, telephone from customer" };
        printf(fence_begin, 5, 2);
        for (int i = 0; i < 1; i++) {
            res = mysql_query(&myConnect, order_5_2[i]);
            if (!res)
            {
                //cout << "query sql '" << order_5_2[i] << " 'succeeded!" << endl;
                result = mysql_store_result(&myConnect);
                    if (result)
                    {
                        int num_fields = mysql_num_fields(result);
                        MYSQL_FIELD* field;
                        char space[] = "                    ";
                        while (field = mysql_fetch_field(result)) {
                            char s[128];
                            sprintf(s, "%s%s", field->name, space);
                            printf("%-30.30s", s);
                        }
                        cout << endl;
                        while (sql_row = mysql_fetch_row(result))//获取具体的数据
                        {
                            for (int i = 0; i < num_fields; i++) {
                                char s[128];
                                sprintf(s, "%s%s", sql_row[i], space);
                                printf("%-30.30s", s);
                            }
                            cout << endl;
                        }
                    }

            }
            else
            {
                cout << "query sql'" << order_5_2[i] << " ' failed!" << endl;
                cout << mysql_error(&myConnect);
                break;
            }
        }

        printf(fence_end);
    }
    return;
}

int main() {
    const char user[] = "admin";
    const char pswd[] = "123";
    const char host[] = "localhost";
    const char db[] = "orderdb";
    unsigned int port = 3309;

    /*MYSQL myConnect;
    MYSQL_RES* result = NULL;
    MYSQL_ROW sql_row;
    int res = 0;
    mysql_init(&myConnect);
    if (mysql_real_connect(&myConnect, host, user, pswd, db, port, NULL, 0))
    {
        //sol_4(myConnect, result, res, sql_row);
        sol_5(myConnect, result, res, sql_row);
    }
    else
    {
        cout << "connect failed!" << endl;
    }
    if (result != NULL)
        mysql_free_result(result);
    mysql_close(&myConnect);*/
    int catalan[11], n = 11;
    int i, j;
    catalan[0] = 1;
    catalan[1] = 1;
    i = 2;
    while (i < n) {
        catalan[i] = 0;
        i = i + 1;
    }
    i = 2;
    while (i < n) {
        j = 0;
        while (j < i) {
            catalan[i] = catalan[i] + catalan[j] * catalan[i - j - 1];
            cout << (catalan[i]) << endl;
            j = j + 1;
        }
        i = i + 1;
    }
    cout << (catalan[n - 1]) << endl;
    return 0;
	return 0;
}