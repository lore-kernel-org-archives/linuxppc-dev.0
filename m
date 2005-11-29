Return-Path: <abutter@hotmail.com>
Received: from hotmail.com (bay110-f8.bay110.hotmail.com [65.54.229.18])
	by ozlabs.org (Postfix) with ESMTP id C8BDB687FD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 22:48:42 +1100 (EST)
Message-ID: <BAY110-F887C1DF4326A978907DBFAE4B0@phx.gbl>
From: "Gao Bismar" <abutter@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Date: Tue, 29 Nov 2005 19:31:32 +0800
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Subject: error when compiling glibc on cygwin
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I wanna complier a MPC860 crosstool on cygwin, and I use crosstool-0.38,but 
hit on error :

powerpc-860-linux-gnu-gcc  -nostdlib -nostartfiles -o 
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/iconv_prog 
 -Wl,-dynamic-linker=/lib/ld.so.1   
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/csu/crt1.o 
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/csu/crti.o 
`powerpc-860-linux-gnu-gcc  --print-file-name=crtbegin.o` 
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/iconv_prog.o 
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/iconv_charmap.o 
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/charmap.o 
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/charmap-dir.o 
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/linereader.o 
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/dummy-repertoire.o 
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/simple-hash.o 
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/xstrdup.o 
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/xmalloc.o 
 
-Wl,-rpath-link=/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc:/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/math:/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/elf:/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/dlfcn:/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/nss:/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/nis:/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/rt:/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/resolv:/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/crypt:/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/linuxthreads 
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6 
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc_nonshared.a 
-lgcc `powerpc-860-linux-gnu-gcc  --print-file-name=crtend.o` 
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/csu/crtn.o


/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/iconv_prog.o(.text+0x424): 
In function `main':: undefined reference to `close'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/iconv_prog.o(.text+0x498): 
In function `main':: undefined reference to `open'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/iconv_prog.o(.text+0x4f8): 
In function `main':: undefined reference to `__fxstat'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/iconv_prog.o(.text+0x530): 
In function `main':: undefined reference to `close'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/iconv_prog.o(.text+0x5bc): 
In function `main':: undefined reference to `close'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/iconv_prog.o(.text+0xb08): 
In function `process_fd':: undefined reference to `read'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/iconv_prog.o(.text+0xbbc): 
In function `process_fd':: undefined reference to `read'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/iconv_prog.o(.text+0x1044): 
In function `print_known_names':: undefined reference to `isatty'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/iconv_charmap.o(.text+0x108): 
In function `charmap_conversion':: undefined reference to `close'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/iconv_charmap.o(.text+0x170): 
In function `charmap_conversion':: undefined reference to `open'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/iconv_charmap.o(.text+0x1c8): 
In function `charmap_conversion':: undefined reference to `__fxstat'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/iconv_charmap.o(.text+0x200): 
In function `charmap_conversion':: undefined reference to `close'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/iconv_charmap.o(.text+0x288): 
In function `charmap_conversion':: undefined reference to `close'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/iconv_charmap.o(.text+0xa78): 
In function `process_fd':: undefined reference to `read'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/iconv_charmap.o(.text+0xb2c): 
In function `process_fd':: undefined reference to `read'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/charmap-dir.o(.text+0x254): 
In function `charmap_readdir':: undefined reference to `__xstat'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/charmap-dir.o(.text+0x388): 
In function `fopen_uncompressed':: undefined reference to `open'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/charmap-dir.o(.text+0x3a0): 
In function `fopen_uncompressed':: undefined reference to `__fxstat'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/charmap-dir.o(.text+0x3c8): 
In function `fopen_uncompressed':: undefined reference to `pipe'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/charmap-dir.o(.text+0x4b0): 
In function `fopen_uncompressed':: undefined reference to `close'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/charmap-dir.o(.text+0x4b8): 
In function `fopen_uncompressed':: undefined reference to `close'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/charmap-dir.o(.text+0x4dc): 
In function `fopen_uncompressed':: undefined reference to `close'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/charmap-dir.o(.text+0x4e4): 
In function `fopen_uncompressed':: undefined reference to `close'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/charmap-dir.o(.text+0x4ec): 
In function `fopen_uncompressed':: undefined reference to `close'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__dup'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `utime'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__libc_fcntl'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__write'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__getcwd'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__dup2'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__read'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__unlink'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__open'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__libc_read'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__xstat64'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__lxstat'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__chmod'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__isatty'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__statfs'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__chdir'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__readlink'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__mkdir'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__poll'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__statvfs64'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__pipe'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__libc_open'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__chown'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__xmknod'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__lseek'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `dup'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `atexit'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__lxstat64'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__ttyname_r'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__libc_lseek'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__rmdir'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__fstatfs'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__close'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__fxstat64'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__libc_write'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__fcntl'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__access'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__open64'
/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/libc.so.6: 
undefined reference to `__fstatvfs64'
collect2: ld returned 1 exit status
make[2]: *** 
[/home/crosstool-0.38/build/powerpc-860-linux-gnu/gcc-2.95.3-glibc-2.2.3/build-glibc/iconv/iconv_prog] 
Error 1
make[2]: Leaving directory `/home/src/glibc-2.2.3/iconv'
make[1]: *** [iconv/others] Error 2
make[1]: Leaving directory `/home/src/glibc-2.2.3'
make: *** [all] Error 2

I use google to search the solution but faild. Many people hit on this 
error, but none solution was found.

Any help would be very much appreciated.

Thaks

                                                                     abutter

_________________________________________________________________
√‚∑—œ¬‘ÿ MSN Explorer:   http://explorer.msn.com/lccn/  
