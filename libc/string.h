#ifndef _LIBC_STRING_H
#define _LIBC_STRING_H

#include <stddef.h>

void* memset(void* str, unsigned char c, size_t n) {
	unsigned char* write = str; // Saving str | Returned
	for(size_t i = 0; i < n; i++)
		*(write++) = c;
	return str;
}

void* memcpy(void* dest, const void* src, size_t n) {
	unsigned char* write = dest; // Saving dest | Returned
	const unsigned char* read = src;
	for(size_t i = 0; i < n; i++)
		*(write++) = *(read++);
	return dest;
}

size_t strlen(const char* str) {
	size_t len = 0;
	while(str[len])
		len++;
	return len;
}

char* strcpy(char* dest, const char* src) {
	size_t str_len = strlen(src);
	char* write = dest;

	for(size_t i = 0; i < str_len; i++)
		*(write++) = *(src++);

	return dest;
}

#endif
