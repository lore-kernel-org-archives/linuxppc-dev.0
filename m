Message-ID: <38062B18.A959825E@mondonet.net>
Date: Thu, 14 Oct 1999 12:12:24 -0700
From: Mario Scarpa <m.scarpa@mondonet.net>
MIME-Version: 1.0
To: PPC-DEV <linuxppc-dev@lists.linuxppc.org>
Subject: serial on lombard
Content-Type: multipart/mixed;
 boundary="------------AA8B68DBDA289AD3174BC1AA"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------AA8B68DBDA289AD3174BC1AA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi there,

there's something I cannot get rid of. When I try to
use minicom to dial with the internal modem of my
lombard 400MHz I get a "/dev/ttyS0 no such file or dir"
error; when I try to use setserial or stty on the same
device everything works ok. I'm using debian potato.
Attached there 's the 'strace minicom' output: hope this helps.

Thanks guys and ... great work !

-- 
Mario Scarpa

Mondonet NOC
Phone: +39 06 52.47.37.02
--------------AA8B68DBDA289AD3174BC1AA
Content-Type: text/plain; charset=us-ascii;
 name="out"
Content-Disposition: inline;
 filename="out"
Content-Transfer-Encoding: 7bit

execve("/usr/bin/minicom", ["minicom"], [/* 22 vars */]) = 0
brk(0)                                  = 0x1876b1c
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=0200000, st_size=939928254, ...}) = 0
mmap(ptrace: umoven: Input/output error
)                                  = 0x30014000
close(3)                                = 0
open("/lib/libncurses.so.4", O_RDONLY)  = 3
fstat(3, {st_mode=0200000, st_size=939928248, ...}) = 0
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
mmap(ptrace: umoven: Input/output error
)                                  = 0x1755000
mprotect(0x1798000, 359544, PROT_NONE)  = 0
mmap(0, 0, PROT_NONE, MAP_FILE, 0, 0)   = 0x17d5000
mmap(0, 0, PROT_NONE, MAP_FILE, 0, 0)   = 0x17ec000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
fstat(3, {st_mode=0200000, st_size=939928254, ...}) = 0
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
mmap(ptrace: umoven: Input/output error
)                                  = 0x30016000
mmap(ptrace: umoven: Input/output error
)                                  = 0x163c000
mprotect(0x171e000, 159112, PROT_NONE)  = 0
mmap(0x8080808, 134744072, 0x8080808, MAP_PRIVATE|0x10200, 50529027, 0x4040404) = 0x172c000
mmap(0, 0, PROT_NONE, MAP_FILE, 0, 0)   = 0x1741000
close(3)                                = 0
munmap(0x30014000, 8116)                = 0
getpid()                                = 455
brk(0)                                  = 0x1876b1c
brk(0x1876cbc)                          = 0x1876cbc
brk(0)                                  = 0x1876cbc
brk(0x1877000)                          = 0x1877000
getuid()                                = 0
getgid()                                = 0
geteuid()                               = 0
getegid()                               = 0
brk(0)                                  = 0x1877000
brk(0x1878000)                          = 0x1878000
socket(PF_UNIX, SOCK_STREAM, 0)         = 3
connect(3, {sun_family=AF_UNIX, sun_path="/var/run/.nscd_socket"}, 110) = -1 ECONNREFUSED (Connection refused)
close(3)                                = 0
open("/etc/nsswitch.conf", O_RDONLY)    = 3
fstat(3, {st_mode=0200000, st_size=939928248, ...}) = 0
mmap(ptrace: umoven: Input/output error
)                                  = 0x30014000
read(3, "# /etc/nsswitch.conf\n#\n# Examp"..., 4096) = 465
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x30014000, 4096)                = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=0200000, st_size=939928254, ...}) = 0
mmap(ptrace: umoven: Input/output error
)                                  = 0x30014000
close(3)                                = 0
open("/lib/libnss_compat.so.2", O_RDONLY) = 3
fstat(3, {st_mode=0200000, st_size=939928248, ...}) = 0
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
mmap(ptrace: umoven: Input/output error
)                                  = 0x1610000
mprotect(0x161b000, 67532, PROT_NONE)   = 0
mmap(0, 0, PROT_NONE, MAP_FILE, 0, 0)   = 0x1620000
close(3)                                = 0
open("/lib/libnsl.so.1", O_RDONLY)      = 3
fstat(3, {st_mode=0200000, st_size=939928254, ...}) = 0
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
mmap(ptrace: umoven: Input/output error
)                                  = 0x15d7000
mprotect(0x15eb000, 85880, PROT_NONE)   = 0
mmap(0, 0, PROT_NONE, MAP_FILE, 0, 0)   = 0x15f7000
mmap(0, 0, PROT_NONE, MAP_FILE, 0, 0)   = 0x15fe000
close(3)                                = 0
munmap(0x30014000, 8116)                = 0
uname({sys="Linux", node="caramela", ...}) = 0
open("/etc/passwd", O_RDONLY)           = 3
fcntl(3, F_GETFD)                       = 0
fcntl(3, F_SETFD, FD_CLOEXEC)           = 0
fstat(3, {st_mode=0200000, st_size=939928248, ...}) = 0
mmap(ptrace: umoven: Input/output error
)                                  = 0x30014000
_llseek(0x3, 0, 0, 0x7ffff648, 0x1)     = 0
read(3, "root:x:0:0:root:/root:/bin/bash\n"..., 4096) = 1517
close(3)                                = 0
munmap(0x30014000, 4096)                = 0
open("/etc/minirc.dfl", O_RDONLY)       = 3
fstat(3, {st_mode=0200000, st_size=939928248, ...}) = 0
mmap(ptrace: umoven: Input/output error
)                                  = 0x30014000
read(3, "# Machine-generated file - use \""..., 4096) = 300
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x30014000, 4096)                = 0
open("/root/.minirc.dfl", O_RDONLY)     = -1 ENOENT (No such file or directory)
open("/root/.macros", O_RDONLY)         = -1 ENOENT (No such file or directory)
setregid(0, 0)                          = 0
setreuid(0, 0)                          = 0
stat("/var/lock", {st_mode=0400000, st_size=25, ...}) = 0
open("/var/lock/LCK..ttyS0", O_RDONLY)  = -1 ENOENT (No such file or directory)
rt_sigaction(0xe, 0x7ffff698, 0x7ffff728, 0x8) = 0
alarm(0x2, 0x7ffff7b4, 0, 0x8, 0x7f7f7f7f) = 0
open("/dev/ttyS0", O_RDWR|O_NONBLOCK)   = 3
--- SIGALRM (Alarm clock) ---
alarm(0, 0x1, 0, 0x8, 0x7f7f7f7f)       = 0
rt_sigaction(0xe, 0x7ffff698, 0x7ffff728, 0x8) = 0
write(2, "minicom: cannot open /dev/ttyS0:"..., 59minicom: cannot open /dev/ttyS0: No such file or directory
) = 59
setregid(0, 0)                          = 0
setreuid(0, 0)                          = 0
exit(1)                                 = ?

--------------AA8B68DBDA289AD3174BC1AA--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
