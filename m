MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: kernel 2.6.6 on ppc405 ?
Date: Wed, 9 Jun 2004 08:42:48 +0200
Message-ID: <80908CC5B2C9DB47AAF8C77892FCB44315F7B0@lion.vector.com.pl>
From: "Andriy Korud" <a.korud@vector.com.pl>
To: "Christos Pasalidis" <cpas@intracom.gr>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, I'm running Mvista's 2.5 tree (actually 2.6.5) on 405EP (PPchameleon). The only problem was to fix early platform setup code in /arch/ppc/platforms/4xx/

regards,

Andriy Korud


-----Original Message-----
From:	owner-linuxppc-embedded@lists.linuxppc.org on behalf of Christos Pasalidis
Sent:	Tue 08.06.2004 15:32
To:	linuxppc-embedded@lists.linuxppc.org
Cc:
Subject:	kernel 2.6.6 on ppc405 ?


Hi

Has anyone managed to run the v2.6.6_linuxppc kernel on a ppc405 based
system ? (e.g Dreambox ) My attempt does not work when it tries to mount
/proc. Then mount receives SIGSEGV.

If you have any idea, about what could be wrong, i 'd love to look at it...

Thanks in advance,
Christos

cnp: trying to strace mount proc
execve("/bin/mount", ["mount", "-t", "proc", "proc", "/proc"], [/* 10 vars
*/])0
brk(0)                                  = 0x10023000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4614, ...}) = 0
mmap(NULL, 4614, PROT_READ, MAP_PRIVATE, 3, 0) = 0x30017000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\1\310"..., 1024)
= 4
fstat64(3, {st_mode=S_IFREG|0755, st_size=11432222, ...}) = 0
mmap(0xfea5000, 1353160, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xfea5000
mprotect(0xffd6000, 103880, PROT_NONE)  = 0
mmap(0xffe5000, 24576, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED, 30
mmap(0xffeb000, 17864, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MA0
close(3)                                = 0
mprotect(0xfea5000, 1249280, PROT_READ|PROT_WRITE) = 0
mprotect(0xfea5000, 1249280, PROT_READ|PROT_EXEC) = 0
munmap(0x30017000, 4614)                = 0
brk(0)                                  = 0x10023000
brk(0x10024000)                         = 0x10024000
umask(033)                              = 022
open("/dev/null", O_RDWR|O_LARGEFILE)   = 3
close(3)                                = 0
getuid()                                = 0
geteuid()                               = 0
lstat64("/etc/mtab", {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
stat64("/sbin/mount.proc", 0x7ffffbc8)  = -1 ENOENT (No such file or
directory)
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++


-----------------------------------------------
 Christos Pasalidis, MSc
 Software Engineer

 INTRACOM S.A.
 Hellenic Telecommunications & Electronics Industry
 New Technologies Dept.
 Embedded Systems Group
 P.O. Box 68, 19.5 km Markopoulo Ave.
 190 02 Peania, Athens, GREECE
 Tel.: (+30 1) 667 4711, 667 9000
 Fax.:(+30 1) 667 7101
 email: cpas@intracom.gr
 URL: www.intracom.gr

My opinions are mine


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
