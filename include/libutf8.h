#ifndef _LIBUTF8_H_
#define _LIBUTF8_H_ 1

#include <wchar.h> // mbstate_t

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

/* from widechar/utf8_mbfuncs.c */
int mblen(const char *, size_t);
size_t mbrlen(const char *, size_t, mbstate_t *);

// defined also in stdlib.h
int mbtowc(wchar_t *, const char *, size_t);
int wctomb(char *, wchar_t);

// defined also in wchar.h
size_t mbrtowc(wchar_t *, const char *, size_t n, mbstate_t *);
size_t wcrtomb(char *, wchar_t, mbstate_t *);
size_t mbstowcs(wchar_t *, const char *, size_t);
size_t wcstombs(char *, const wchar_t *, size_t);
size_t mbsrtowcs(wchar_t *, const char **, size_t, mbstate_t *);
size_t wcsrtombs(char *, const wchar_t **, size_t, mbstate_t *);

size_t u8_strlen(char *);
size_t u8_strnlen(char *, size_t);

#define state_unused
#define count_mbytes(buffer,length,state) mblen(buffer,length)
#define reset_mbytes(state) /* not required for us */
#define check_mbytes(wch,buffer,length,state) \
        (int) mbtowc(&wch, buffer, length)

#endif /* _LIBUTF8_H_ */
