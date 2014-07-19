/**
 * Add some missing implementation of mb functions in bionic
 *
 * This unit implements a simple conversion of UTF-8 to char_t[]
 * This is not the real wchar_t format, which is not supported by
 * bionic, but a simple copy of 8 to 32bit UTF-8 to a 32bit int.
 *
 * Unlike linux wchar funcs, these functions keep UTF-8 size headers
 *
 * tpruvot@github - 2014 - Apache Licence (Free to use / include)
 *
 ******************************************************************/

#include <wchar.h>
#include <stdlib.h>

size_t u8_strnlen(const char *buf, size_t maxlen);
size_t u8_strlen(const char *buf);

static mbstate_t mbs = {0};

int mblen(const char *s, size_t n)
{
	int buf_mb_len = 1;

	if (s == NULL) {
		/* No support for state dependent encodings. */
		memset(&mbs, 0, sizeof(mbs));
		return (0);
	}

	if ((*s & 0xF0) == 0xF0)
		buf_mb_len = 4; // start of 4-char utf series
	else if ((*s & 0xF0) == 0xE0)
		buf_mb_len = 3; // start of 3-char
	else if ((*s & 0xF0) == 0xC0)
		buf_mb_len = 2; // start of 2-char
	else if ((*s & 0xC0) == 0x80)
		buf_mb_len = 0; // utf hidden part

	return (buf_mb_len);
}

size_t mbrlen(const char *s, size_t n, mbstate_t *st)
{
	return (size_t) mblen(s,n);
}

/* mb char -> wchar (simple cast) */
int mbtowc(wchar_t * __restrict__ wc, const char * __restrict__ src, size_t n)
{
	int len = mblen(src, n);
	if (!wc) return 0;

	*wc = 0;
	if (len > 0)
		memcpy((char*) wc, src, len);

	return len;
}

size_t mbrtowc(wchar_t * wc, const char * src, size_t n, mbstate_t *st)
{
	return (int) mbtowc(wc, src, n);
}

/* wchar -> mb char (simple cast) */
int wctomb(char * s, wchar_t wc)
{
	int len;
	if (!s) return 0;

	s[0] = wc & 0xFF;
	if (s[0]) s[1] = (wc & 0xFF00) >> 8;
	if (s[1]) s[2] = (wc & 0xFF0000) >> 16;
	if (s[2]) s[3] = (wc & 0xFF000000) >> 24;
	if (s[3]) s[4] = '\0';

	len = mblen(s, 4);
	return len;
}

size_t wcrtomb(char * s, wchar_t wc, mbstate_t *st)
{
	return (int) wctomb(s, wc);
}

size_t wcsrtombs(char *dst, const wchar_t **src, size_t len, mbstate_t *ps)
{
	size_t n, sz, cnt = 0;
	char * dp;
	const wchar_t *sp;

	if (src == NULL)
		return 0;

	sp = *src;
	if (dst == NULL) {
		char tmp[8];
		/* Count only */
		while (cnt < len && *sp != 0) {
			sz = wctomb(tmp, *sp); sp++;
			cnt += sz;
		}
		return cnt;
	}

	n = len;
	dp = dst;
	while (n > 0) {
		if (*sp == 0)
			break;

		sz = wctomb(dp, *sp); sp++;

		dp += sz;
		cnt += sz;
		n--;
	}
	*dp = '\0';

	return cnt;
}

size_t wcstombs(char *dst, const wchar_t *src, size_t len)
{
	return wcsrtombs(dst, &src, len, NULL);
}

size_t mbstowcs(wchar_t *dst, const char *src, size_t len)
{
	size_t sz, cnt = 0;
	const char *sp = src;
	wchar_t *dp = dst;

	if (src == NULL)
		return 0;

	while (cnt < len && *sp != '\0') {
		sz = mbtowc(dst, sp, MB_CUR_MAX);
		dst++; cnt++;
		sp += sz;
	}

	return cnt;
}

size_t mbsrtowcs(wchar_t *dst, const char **src, size_t len, mbstate_t *ps)
{
	if (src == NULL)
		return 0;
	return mbstowcs(dst, *src, len);
}

/* This function is equivalent to strlen() for utf-8 strings. */
size_t u8_strnlen(const char *buf, size_t maxlen)
{
	size_t len = 0;
	const char *s = buf;

	while (*s) {
		if (len >= maxlen) break;
		len += ((*s++ & 0xC0) != 0x80);
	}
	return len;
}

/* This function is equivalent to strlen() for utf-8 strings. */
size_t u8_strlen(const char *buf)
{
	return u8_strnlen(buf, (size_t)-1);
}
