#ifndef _LIBUTF8_H_
#define _LIBUTF8_H_ 1

/* from widechar/mblen.c */
int mblen(const char *s, size_t n);

size_t u8_strlen(char *buf);
size_t u8_strnlen(char *buf, size_t maxlen);

#endif /* _LIBUTF8_H_ */
