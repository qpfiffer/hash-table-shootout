#include <simple_sparsehash.h>
#define SETUP struct sparse_dict *dict = sparse_dict_init();
#define INSERT_INT_INTO_HASH(key, value) sparse_dict_set(dict, key, strlen(key), value, sizeof(value))
/* #define DELETE_INT_FROM_HASH(key) g_hash_table_remove(hash, GINT_TO_POINTER(key)) */
#define INSERT_STR_INTO_HASH(key, value) sparse_dict_set(dict, key, strlen(key), value, strlen(value))
/* #define DELETE_STR_FROM_HASH(key) g_hash_table_remove(str_hash, key) */
#include "template.c"

