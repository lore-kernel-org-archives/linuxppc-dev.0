Message-ID: <6B546A602AD2D211BFF00008C7A4288905843F7E@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'Gerhard TAEUBL '" <Gerhard.TAEUBL@frequentis.com>,
	"'linuxppc-embedded@lists.linuxppc.org '" <linuxppc-embedded@lists.linuxppc.org>,
	Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
Subject: RE: RE: RE: Password for embedded Linux
Date: Thu, 13 Dec 2001 15:49:41 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I put strace of the target and modified inittab with
ttyS0::respawn:/usr/bin/strace /sbin/getty -L ttyS0 9600 vt100

This is what I get, you could compare it with what you have:

execve("/sbin/getty", ["/sbin/getty", "-L", "ttyS0", "9600", "vt100"], [/* 5
vars */]) = 0
brk(0)                                  = 0x100214c4
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = -1 ENOENT (No such file or
directory)
open("/lib/libcrypt.so.1", O_RDONLY)    = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0\23"..., 1024)
= 1024
fstat64(0x3, 0x7ffff270)                = 0
mmap(0xffb3000, 247612, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xffb3000
mprotect(0xffb8000, 227132, PROT_NONE)  = 0
mmap(0xffc3000, 24576, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED, 3, 0) = 0xffc3000
mmap(0xffc9000, 157500, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xffc9000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\2\237"..., 1024)
= 1024
fstat64(0x3, 0x7ffff250)                = 0
mmap(0xfe63000, 1307608, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xfe63000
mprotect(0xff74000, 189400, PROT_NONE)  = 0
mmap(0xff83000, 106496, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED, 3, 0x110000) = 0xff83000
mmap(0xff9d000, 21464, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xff9d000
close(3)                                = 0
getpid()                                = 191
getuid()                                = 0
setuid(0)                               = 0
getgid()                                = 0
setgid(0)                               = 0
brk(0)                                  = 0x100214c4
brk(0x100214e4)                         = 0x100214e4
brk(0x10022000)                         = 0x10022000
setsid()                                = 191
getpid()                                = 191
access("/var/run/utmpx", F_OK)          = -1 ENOENT (No such file or
directory)
open("/var/run/utmp", O_RDWR)           = 3
fcntl64(0x3, 0x1, 0)                    = 0
fcntl64(0x3, 0x2, 0x1)                  = 0
_llseek(0x3, 0, 0, 0x7ffffb98, 0)       = 0
alarm(0, 0x7ffffbd8, 0, 0x7ffffb98, 0)  = 0
rt_sigaction(SIGALRM, {0xff6b3c0, [], 0}, {SIG_DFL}, 8) = 0
alarm(0x1, 0x7ffffa24, 0, 0x8, 0)       = 0
fcntl64(0x3, 0x7, 0x7ffffa58)           = 0
read(3, "", 384)                        = 0
fcntl64(0x3, 0x7, 0x7ffffa58)           = 0
rt_sigaction(SIGALRM, {SIG_DFL}, NULL, 8) = 0
alarm(0, 0x7ffff908, 0, 0x8, 0)         = 1
time([1426369238])                      = 1426369238
alarm(0, 0x7ffff8f8, 0x20, 0x8, 0)      = 0
rt_sigaction(SIGALRM, {0xff6b3c0, [], 0}, {SIG_DFL}, 8) = 0
alarm(0x1, 0x7ffff764, 0, 0x8, 0)       = 0
fcntl64(0x3, 0x7, 0x7ffff798)           = 0
read(3, "", 384)                        = 0
fcntl64(0x3, 0x7, 0x7ffff798)           = 0
rt_sigaction(SIGALRM, {SIG_DFL}, NULL, 8) = 0
alarm(0, 0x7ffff648, 0, 0x8, 0)         = 1
alarm(0, 0x7ffff648, 0, 0x8, 0)         = 0
rt_sigaction(SIGALRM, {0xff6b3c0, [], 0}, {SIG_DFL}, 8) = 0
alarm(0x1, 0x7ffff8c4, 0, 0x8, 0)       = 0
fcntl64(0x3, 0x7, 0x7ffffa78)           = 0
_llseek(0x3, 0, 0, 0x7ffff8d8, 0x2)     = 0
write(3, "\0\6\0\0\0\0\0\277ttyS0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 384)
= 384
fcntl64(0x3, 0x7, 0x7ffffa78)           = 0
rt_sigaction(SIGALRM, {SIG_DFL}, NULL, 8) = 0
alarm(0, 0x7ffff7a8, 0, 0x8, 0xc000)    = 1
close(3)                                = 0
access("/var/log/wtmpx", F_OK)          = -1 ENOENT (No such file or
directory)
open("/var/log/wtmp", O_WRONLY)         = 3
alarm(0, 0x1, 0x70000000, 0x70780000, 0xfefefeff) = 0
rt_sigaction(SIGALRM, {0xff6b3c0, [], 0}, {SIG_DFL}, 8) = 0
alarm(0x1, 0x7ffffa44, 0, 0x8, 0xfefefeff) = 0
fcntl64(0x3, 0x7, 0x7ffffa78)           = 0
_llseek(0x3, 0, 0, 0x7ffffa58, 0x2)     = 0
write(3, "\0\6\0\0\0\0\0\277ttyS0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 384)
= 384
fcntl64(0x3, 0x7, 0x7ffffa78)           = 0
rt_sigaction(SIGALRM, {SIG_DFL}, NULL, 8) = 0
alarm(0, 0x7ffff928, 0, 0x8, 0xc000)    = 1
close(3)                                = 0
close(1)                                = 0
close(2)                                = 0
chdir("/dev")                           = 0
stat("ttyS0", {st_mode=S_IFCHR|0622, st_rdev=makedev(4, 64), ...}) = 0
close(0)                                = 0
open("ttyS0", O_RDWR|O_NONBLOCK)        = 0
dup(0)                                  = 1
dup(0)                                  = 2
ioctl(0, 0x402c7413, 0x7ffffb58)        = 0
chown("ttyS0", 0, 0)                    = 0
chmod("ttyS0", 0622)                    = 0
getpid()                                = 191
ioctl(0, 0x80047476, 0x7ffffe0c)        = -1 ENOTTY (Inappropriate ioctl for
device)
write(2, "getty: ", 7)                  = -1 EAGAIN (Resource temporarily
unavailable)
write(2, "ioctl() TIOCSPGRP call failed", 29) = -1 EAGAIN (Resource
temporarily unavailable)
write(2, ": ", 2)                       = -1 EAGAIN (Resource temporarily
unavailable)
write(2, "Resource temporarily unavailable"..., 33) = -1 EAGAIN (Resource
temporarily unavailable)
ioctl(0, 0x2000741f, 0x2)               = 0
ioctl(0, 0x802c7414, 0x7ffffc88)        = 0
ioctl(0, 0x402c7413, 0x7ffffc88)        = 0
fcntl64(0, 0x3, 0)                      = 2050
fcntl64(0, 0x4, 0x2)                    = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
nanosleep({1, 0}, {1, 0})               = 0
ioctl(0, 0x2000741f, 0)                 = 0
uname({sys="Linux", node="target", ...}) = 0
write(1, "\r\n", 2
)                     = 2
open("/etc/issue", O_RDONLY)            = 3
ioctl(0, 0x802c7415, 0x7ffff948)        = 0
fstat64(0x3, 0x7ffff948)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x30017000
read(3, "MontaVista Software\'s Hard Hat L"..., 4096) = 42
fstat64(0x1, 0x7ffff938)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x30018000
ioctl(1, 0x402c7413, 0x7ffff7b8)        = 0
write(1, "MontaVista Software\'s Hard Hat L"..., 41MontaVista Software's
Hard Hat Linux 2.0
) = 41
write(1, "\n", 1
)                       = 1
read(3, "", 4096)                       = 0
ioctl(0, 0x802c7415, 0x7ffff948)        = 0
close(3)                                = 0
munmap(0x30017000, 4096)                = 0
uname({sys="Linux", node="target", ...}) = 0
write(1, "target", 6target)                   = 6
write(1, " login: ", 8 login: )                 = 8
read(0, root
"r", 1)                         = 1
write(1, "r", 1r)                        = 1
read(0, "o", 1)                         = 1
write(1, "o", 1o)                        = 1
read(0, "o", 1)                         = 1
write(1, "o", 1o)                        = 1
read(0, "t", 1)                         = 1
write(1, "t", 1t)                        = 1
read(0, "\r", 1)                        = 1
ioctl(0, 0x802c7414, 0x7ffffc98)        = 0
ioctl(0, 0x402c7413, 0x7ffffc98)        = 0
write(1, "\n", 1
)                       = 1
execve("/bin/login", ["/bin/login", "--", "root"], [/* 5 vars */]) = 0
brk(0)                                  = 0x100214c4
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = -1 ENOENT (No such file or
directory)
open("/lib/libcrypt.so.1", O_RDONLY)    = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0\23"..., 1024)
= 1024
fstat64(0x3, 0x7ffff280)                = 0
mmap(0xffb3000, 247612, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xffb3000
mprotect(0xffb8000, 227132, PROT_NONE)  = 0
mmap(0xffc3000, 24576, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED, 3, 0) = 0xffc3000
mmap(0xffc9000, 157500, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xffc9000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\2\237"..., 1024)
= 1024
fstat64(0x3, 0x7ffff260)                = 0
mmap(0xfe63000, 1307608, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xfe63000
mprotect(0xff74000, 189400, PROT_NONE)  = 0
mmap(0xff83000, 106496, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED, 3, 0x110000) = 0xff83000
mmap(0xff9d000, 21464, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xff9d000
close(3)                                = 0
getpid()                                = 191
getuid()                                = 0
setuid(0)                               = 0
getgid()                                = 0
setgid(0)                               = 0
brk(0)                                  = 0x100214c4
brk(0x1002151c)                         = 0x1002151c
brk(0x10022000)                         = 0x10022000
getuid()                                = 0
rt_sigaction(SIGALRM, {0x100055cc, [ALRM], SA_RESTART}, {SIG_DFL}, 8) = 0
ioctl(0, 0x402c7413, 0x7fffd978)        = 0
ioctl(1, 0x402c7413, 0x7fffd978)        = 0
ioctl(2, 0x402c7413, 0x7fffd978)        = 0
getpid()                                = 191
access("/var/run/utmpx", F_OK)          = -1 ENOENT (No such file or
directory)
open("/var/run/utmp", O_RDWR)           = 3
fcntl64(0x3, 0x1, 0)                    = 0
fcntl64(0x3, 0x2, 0x1)                  = 0
_llseek(0x3, 0, 0, 0x7fffda78, 0)       = 0
alarm(0, 0x7fffdab8, 0, 0x7fffda78, 0)  = 0
rt_sigaction(SIGALRM, {0xff6b3c0, [], 0}, {0x100055cc, [ALRM], SA_RESTART},
8) = 0
alarm(0x1, 0x7fffd904, 0, 0x8, 0)       = 0
fcntl64(0x3, 0x7, 0x7fffd938)           = 0
read(3, "\0\6\0\0\0\0\0\277ttyS0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 384) =
384
fcntl64(0x3, 0x7, 0x7fffd938)           = 0
rt_sigaction(SIGALRM, {0x100055cc, [ALRM], SA_RESTART}, NULL, 8) = 0
alarm(0, 0x7fffd7e8, 0, 0x8, 0)         = 1
ioctl(0, 0x402c7413, 0x7fffd738)        = 0
brk(0x10024000)                         = 0x10024000
readlink("/proc/self/fd/0", "/dev/ttyS0", 4095) = 10
alarm(0x3c, 0x1000b8e7, 0x1, 0, 0x7efefeff) = 0
open("/etc/passwd", O_RDONLY)           = 4
read(4, "root:hitEwHOzmuFKw:0:0:root:/roo"..., 256) = 256
lseek(4, -214, SEEK_CUR)                = 42
close(4)                                = 0
open("/etc/securetty", O_RDONLY)        = -1 ENOENT (No such file or
directory)
brk(0x10027000)                         = 0x10027000
time([1426369255])                      = 1426369255
open("/etc/localtime", O_RDONLY)        = 4
fstat64(0x4, 0x7fffb428)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x30017000
read(4, "TZif\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\n\0"..., 4096) =
1067
close(4)                                = 0
munmap(0x30017000, 4096)                = 0
getpid()                                = 191
rt_sigaction(SIGPIPE, {0xff3c3f4, [], 0}, {SIG_DFL}, 8) = 0
socket(PF_UNIX, SOCK_DGRAM, 0)          = 4
fcntl64(0x4, 0x2, 0x1)                  = 0
connect(4, {sin_family=AF_UNIX, path="/dev/log"}, 16) = -1 EPROTOTYPE
(Protocol wrong type for socket)
close(4)                                = 0
socket(PF_UNIX, SOCK_STREAM, 0)         = 4
fcntl64(0x4, 0x2, 0x1)                  = 0
connect(4, {sin_family=AF_UNIX, path="/dev/log"}, 16) = 0
send(4, "<36>Mar 14 22:40:55 login[191]: "..., 61, 0) = 61
rt_sigaction(SIGPIPE, {SIG_DFL}, NULL, 8) = 0
open("/dev/tty", O_RDWR|O_CREAT|O_TRUNC, 0666) = -1 ENXIO (No such device or
address)
ioctl(0, 0x402c7413, 0x7fffd908)        = 0
ioctl(0, 0x802c7416, 0x7fffd9d8)        = 0
write(2, "Password: ", 10Password: )              = 10
fstat64(0, 0x7fffd928)                  = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x30017000
ioctl(0, 0x402c7413, 0x7fffd7a8)        = 0
read(0, 0x30017000, 4096)               = ? ERESTARTSYS (To be restarted)
--- SIGALRM (Alarm clock) ---
write(2, "login: ", 7login: )                  = 7
write(2, "\nLogin timed out after 60 second"..., 35
Login timed out after 60 seconds.
) = 35
exit(0)                                 = ?
execve("/sbin/getty", ["/sbin/getty", "-L", "ttyS0", "9600", "vt100"], [/* 5
vars */]) = 0
brk(0)                                  = 0x100214c4
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = -1 ENOENT (No such file or
directory)
open("/lib/libcrypt.so.1", O_RDONLY)    = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0\23"..., 1024)
= 1024
fstat64(0x3, 0x7ffff270)                = 0
mmap(0xffb3000, 247612, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xffb3000
mprotect(0xffb8000, 227132, PROT_NONE)  = 0
mmap(0xffc3000, 24576, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED, 3, 0) = 0xffc3000
mmap(0xffc9000, 157500, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xffc9000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\2\237"..., 1024)
= 1024
fstat64(0x3, 0x7ffff250)                = 0
mmap(0xfe63000, 1307608, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xfe63000
mprotect(0xff74000, 189400, PROT_NONE)  = 0
mmap(0xff83000, 106496, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED, 3, 0x110000) = 0xff83000
mmap(0xff9d000, 21464, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xff9d000
close(3)                                = 0
getpid()                                = 193
getuid()                                = 0
setuid(0)                               = 0
getgid()                                = 0
setgid(0)                               = 0
brk(0)                                  = 0x100214c4
brk(0x100214e4)                         = 0x100214e4
brk(0x10022000)                         = 0x10022000
setsid()                                = 193
getpid()                                = 193
access("/var/run/utmpx", F_OK)          = -1 ENOENT (No such file or
directory)
open("/var/run/utmp", O_RDWR)           = 3
fcntl64(0x3, 0x1, 0)                    = 0
fcntl64(0x3, 0x2, 0x1)                  = 0
_llseek(0x3, 0, 0, 0x7ffffb98, 0)       = 0
alarm(0, 0x7ffffbd8, 0, 0x7ffffb98, 0)  = 0
rt_sigaction(SIGALRM, {0xff6b3c0, [], 0}, {SIG_DFL}, 8) = 0
alarm(0x1, 0x7ffffa24, 0, 0x8, 0)       = 0
fcntl64(0x3, 0x7, 0x7ffffa58)           = 0
read(3, "\0\6\0\0\0\0\0\277ttyS0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 384) =
384
fcntl64(0x3, 0x7, 0x7ffffa58)           = 0
rt_sigaction(SIGALRM, {SIG_DFL}, NULL, 8) = 0
alarm(0, 0x7ffff908, 0, 0x8, 0)         = 1
alarm(0, 0x7ffffbd8, 0, 0x8, 0)         = 0
rt_sigaction(SIGALRM, {0xff6b3c0, [], 0}, {SIG_DFL}, 8) = 0
alarm(0x1, 0x7ffffa24, 0, 0x8, 0)       = 0
fcntl64(0x3, 0x7, 0x7ffffa58)           = 0
read(3, "", 384)                        = 0
fcntl64(0x3, 0x7, 0x7ffffa58)           = 0
rt_sigaction(SIGALRM, {SIG_DFL}, NULL, 8) = 0
alarm(0, 0x7ffff908, 0, 0x8, 0)         = 1
time([1426369319])                      = 1426369319
alarm(0, 0x7ffff8f8, 0x20, 0x8, 0)      = 0
rt_sigaction(SIGALRM, {0xff6b3c0, [], 0}, {SIG_DFL}, 8) = 0
alarm(0x1, 0x7ffff764, 0, 0x8, 0)       = 0
fcntl64(0x3, 0x7, 0x7ffff798)           = 0
read(3, "", 384)                        = 0
fcntl64(0x3, 0x7, 0x7ffff798)           = 0
rt_sigaction(SIGALRM, {SIG_DFL}, NULL, 8) = 0
alarm(0, 0x7ffff648, 0, 0x8, 0)         = 1
alarm(0, 0x7ffff648, 0, 0x8, 0)         = 0
rt_sigaction(SIGALRM, {0xff6b3c0, [], 0}, {SIG_DFL}, 8) = 0
alarm(0x1, 0x7ffff8c4, 0, 0x8, 0)       = 0
fcntl64(0x3, 0x7, 0x7ffffa78)           = 0
_llseek(0x3, 0, 0, 0x7ffff8d8, 0x2)     = 0
write(3, "\0\6\0\0\0\0\0\301ttyS0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 384)
= 384
fcntl64(0x3, 0x7, 0x7ffffa78)           = 0
rt_sigaction(SIGALRM, {SIG_DFL}, NULL, 8) = 0
alarm(0, 0x7ffff7a8, 0, 0x8, 0xc000)    = 1
close(3)                                = 0
access("/var/log/wtmpx", F_OK)          = -1 ENOENT (No such file or
directory)
open("/var/log/wtmp", O_WRONLY)         = 3
alarm(0, 0x1, 0x70000000, 0x70780000, 0xfefefeff) = 0
rt_sigaction(SIGALRM, {0xff6b3c0, [], 0}, {SIG_DFL}, 8) = 0
alarm(0x1, 0x7ffffa44, 0, 0x8, 0xfefefeff) = 0
fcntl64(0x3, 0x7, 0x7ffffa78)           = 0
_llseek(0x3, 0, 0, 0x7ffffa58, 0x2)     = 0
write(3, "\0\6\0\0\0\0\0\301ttyS0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 384)
= 384
fcntl64(0x3, 0x7, 0x7ffffa78)           = 0
rt_sigaction(SIGALRM, {SIG_DFL}, NULL, 8) = 0
alarm(0, 0x7ffff928, 0, 0x8, 0xc000)    = 1
close(3)                                = 0
close(1)                                = 0
close(2)                                = 0
chdir("/dev")                           = 0
stat("ttyS0", {st_mode=S_IFCHR|0622, st_rdev=makedev(4, 64), ...}) = 0
close(0)                                = 0
open("ttyS0", O_RDWR|O_NONBLOCK)        = 0
dup(0)                                  = 1
dup(0)                                  = 2
ioctl(0, 0x402c7413, 0x7ffffb58)        = 0
chown("ttyS0", 0, 0)                    = 0
chmod("ttyS0", 0622)                    = 0
getpid()                                = 193
ioctl(0, 0x80047476, 0x7ffffe0c)        = -1 ENOTTY (Inappropriate ioctl for
device)
write(2, "getty: ", 7)                  = -1 EAGAIN (Resource temporarily
unavailable)
write(2, "ioctl() TIOCSPGRP call failed", 29) = -1 EAGAIN (Resource
temporarily unavailable)
write(2, ": ", 2)                       = -1 EAGAIN (Resource temporarily
unavailable)
write(2, "Resource temporarily unavailable"..., 33) = -1 EAGAIN (Resource
temporarily unavailable)
ioctl(0, 0x2000741f, 0x2)               = 0
ioctl(0, 0x802c7414, 0x7ffffc88)        = 0
ioctl(0, 0x402c7413, 0x7ffffc88)        = 0
fcntl64(0, 0x3, 0)                      = 2050
fcntl64(0, 0x4, 0x2)                    = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
nanosleep({1, 0}, {1, 0})               = 0
ioctl(0, 0x2000741f, 0)                 = 0
uname({sys="Linux", node="target", ...}) = 0
write(1, "\r\n", 2
)                     = 2
open("/etc/issue", O_RDONLY)            = 3
ioctl(0, 0x802c7415, 0x7ffff948)        = 0
fstat64(0x3, 0x7ffff948)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x30017000
read(3, "MontaVista Software\'s Hard Hat L"..., 4096) = 42
fstat64(0x1, 0x7ffff938)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x30018000
ioctl(1, 0x402c7413, 0x7ffff7b8)        = 0
write(1, "MontaVista Software\'s Hard Hat L"..., 41MontaVista Software's
Hard Hat Linux 2.0
) = 41
write(1, "\n", 1
)                       = 1
read(3, "", 4096)                       = 0
ioctl(0, 0x802c7415, 0x7ffff948)        = 0
close(3)                                = 0
munmap(0x30017000, 4096)                = 0
uname({sys="Linux", node="target", ...}) = 0
write(1, "target", 6target)                   = 6
write(1, " login: ", 8 login: )                 = 8
read(0,

-----Original Message-----
From: Gerhard TAEUBL
To: linuxppc-embedded@lists.linuxppc.org; Frederic.Goddeeris@siemens.atea.be
Sent: 12/13/01 2:31 PM
Subject: Re: RE: RE: Password for embedded Linux


The problem is, that the line

Password:

after login dosen't comes up! Also after calling passwd, only

#passwd
Changing password for root
Bad password: too short.

Warning: weak password (continuing).
Password changed.
#

appears. I think something necessary isn't on the filesystem, but I
don't know what!

>>> Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be> 12/13/01
13:57 PM >>>
I suppose you now have a /etc/passwd that does not specify any password
for
root. So it is normal it does not ask for one when logging in, telnet to
it
or change the pw.

"root" as pw is too small, take something different but when you insist
and
enter it a second time it should accept it...

telnet otncllf
Trying 193.210.198.203...
Connected to otncllf.atea.be.
Escape character is '^]'.

target login: root
Password:
Linux target 2.4.2_hhl20 #44 Wed Dec 12 14:21:21 CET 2001 ppc unknown

Welcome to MontaVista Software's Hard Hat Linux.



BusyBox v0.60.2 (2001.11.28-10:02+0000) Built-in shell (ash)
Enter 'help' for a list of built-in commands.

# passwd
Changing password for root
Enter the new password (minimum of 5, maximum of 8 characters)

                         Please use a combination of upper and lower
case
letters and numbers.
Enter new password:
Bad password: too short.

Warning: weak password (continuing).
Re-enter new password:
Password changed.
#

-----Original Message-----
From: Gerhard TAEUBL
To: linuxppc-embedded@lists.linuxppc.org;
Frederic.Goddeeris@siemens.atea.be
Sent: 12/13/01 1:18 PM
Subject: Re: RE: Password for embedded Linux


I load the tinylogin and compile it (wow it works without any
modification expect the path for corss compile),  could still login!
But when I try passwd and enter for example root I get the error message
to short. It didn't ask me for any old or new password, only it is to
shoort. Also if I do telnet, it won't ask for any password only login I
enter root, thats it! So what do I need?

jffs2: I didn't make tests with heavy load, I only copy some files to
the disk and start it there. This I will do in January.

Gerhard

>>> Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be> 12/13/01
11:07 AM >>>
 My experience is that you need to include a lot of things for the
login.
I used TinyLogin. This will provide everything you need (I also used
Busybox)
In /etc/inittab I added
	ttyS0::respawn:/sbin/getty -L ttyS0 9600 vt100
/sbin/getty points to TinyLogin
getty -> ../bin/tinylogin

You have good experience with JFFS2? What version do you use?

Fred

-----Original Message-----
From: Gerhard TAEUBL
To: linuxppc-embedded@lists.linuxppc.org
Sent: 12/13/01 10:49 AM
Subject: Password for embedded Linux


Hi!

We use HHL1.2 filesystem for a MPC860. Meanwhile everthing works fine
:-) (serial port, jffs2 and so on). I've made a initrd to boot the
system and mount 4MB Flash where the project related data and programs
will be copied. So we could use for nearly every project the same image,
and store the data afterwards via ftp. O.K. but we want to use a
password to login, and I didn't find any hint to do that! So if you have
any ideas...
Thanks in advance
Gerhard


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
