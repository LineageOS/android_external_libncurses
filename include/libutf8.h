#ifndef _LIBUTF8_H_
#define _LIBUTF8_H_ 1

#ifdef __BIONIC__

#ifdef MB_LEN_MAX
#if MB_LEN_MAX == 1
#undef MB_LEN_MAX
#define MB_LEN_MAX 8
#endif
#endif

#ifdef MB_CUR_MAX
#if MB_CUR_MAX == 1
#undef MB_CUR_MAX
#define MB_CUR_MAX 4
#endif
#endif

#endif /* __BIONIC__ */

/* from widechar/mblen.c */
int mblen(const char *s, size_t n);

size_t u8_strlen(char *buf);
size_t u8_strnlen(char *buf, size_t maxlen);

#endif /* _LIBUTF8_H_ */
