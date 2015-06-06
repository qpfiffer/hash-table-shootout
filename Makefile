all: build/simple_sparsehash build/glib_hash_table build/stl_unordered_map build/boost_unordered_map build/google_sparse_hash_map build/google_dense_hash_map build/qt_qhash build/python_dict

build/glib_hash_table: src/glib_hash_table.c Makefile src/template.c
	gcc -ggdb -O2 `pkg-config --cflags glib-2.0` src/glib_hash_table.c -o build/glib_hash_table -lm `pkg-config --libs glib-2.0`

build/stl_unordered_map: src/stl_unordered_map.cc Makefile src/template.c
	g++ -O2 -lm src/stl_unordered_map.cc -o build/stl_unordered_map -std=c++0x

build/boost_unordered_map: src/boost_unordered_map.cc Makefile src/template.c
	g++ -O2 -lm src/boost_unordered_map.cc -o build/boost_unordered_map

build/google_sparse_hash_map: src/google_sparse_hash_map.cc Makefile src/template.c
	g++ -O2 -lm src/google_sparse_hash_map.cc -o build/google_sparse_hash_map

build/google_dense_hash_map: src/google_dense_hash_map.cc Makefile src/template.c
	g++ -O2 -lm src/google_dense_hash_map.cc -o build/google_dense_hash_map

build/qt_qhash: src/qt_qhash.cc Makefile src/template.c
	g++ -O2 `pkg-config --cflags --libs QtCore` src/qt_qhash.cc -o build/qt_qhash -lm `pkg-config --cflags --libs QtCore`

build/simple_sparsehash: src/simple_sparsehash.c Makefile src/template.c
	gcc -O2 src/simple_sparsehash.c -o build/simple_sparsehash -lsimple-sparsehash -lm

build/python_dict: src/python_dict.c Makefile src/template.c
	gcc -O2 -I/usr/include/python2.7 src/python_dict.c -o build/python_dict -lpython2.7 -lm
