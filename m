From: Russell Hires <rhires@earthlink.net>
Reply-To: rhires@earthlink.net
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.4.18 kernel oops report
Date: Sun, 3 Mar 2002 10:41:59 -0500
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_Z9MECURYTHYYHCF1TYJA"
Message-Id: <E16hY7m-0000EU-00@localhost>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--------------Boundary-00=_Z9MECURYTHYYHCF1TYJA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit


Hello! I'm not subscribed to this list, but I thought I'd send this along...I
have a problem with kernel oopses. I'm running a Powermac G3 266 Desktop,
with standard everything, except I've got a Voodoo3 card for my monitor and a
PCI USB Card. I've got 392 (?) MB RAM, a SCSI Drive and two IDE drives. I'm
running a stock 2.4.18 kernel that I got from kernel.org, and this oops has
happened before on previous stock kernels (2.4.17 in particular). I'm sure
that sound is part of the problem. I boot into Linux using BootX, and usually
boot all the way into the MacOS (8.6) to get sound. Sometimes I have a hard
crash, and when I boot back into Linux (going all the way into MacOS), I get
kernel errors while fsck is doing its thing. If I just boot into Linux using
the "Choose Your OS" panel at startup, fsck is able to proceed without any
problem, but I also have no sound...and no oopses, either.

I've run ksymoops through kern.log and syslog after the oops, but the syslog
is more like what I think is necessary to be reported...if you need more, let
me know directly, as I'm not a member of this list...I'm hesitant to send my
System.map to the mailing list, it's kinda big!

Thanks!

Russell


--------------Boundary-00=_Z9MECURYTHYYHCF1TYJA
Content-Type: text/plain;
  charset="iso-8859-1";
  name="oops-report-syslog"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="oops-report-syslog"

ksymoops 2.3.4 on ppc 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol xchg_u32  , ksyms_base says c0=
00bc40, System.map says c0006950.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol hfs_version  , hfs says dba40e=
60, /lib/modules/2.4.18/kernel/fs/hfs/hfs.o says dba415e0.  Ignoring /lib=
/modules/2.4.18/kernel/fs/hfs/hfs.o entry
Mar  2 22:30:17 localhost kernel: 3c59x: Donald Becker and others. www.sc=
yld.com/network/vortex.html
Mar  2 22:30:18 localhost kernel:  0000 0000 0000 0000 0000 0000 0000 000=
0
Mar  2 22:57:14 localhost kernel: Oops: kernel access of bad area, sig: 1=
1
Mar  2 22:57:14 localhost kernel: NIP: C0031908 XER: 00000000 LR: C003179=
0 SP: CD161E00 REGS: cd161d50 TRAP: 0300    Tainted: P=20
Using defaults from ksymoops -t elf32-powerpc -a powerpc:common
Mar  2 22:57:14 localhost kernel: MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 I=
R/DR: 11
Mar  2 22:57:14 localhost kernel: TASK =3D cd160000[818] 'kdeinit' Last s=
yscall: 1=20
Mar  2 22:57:14 localhost kernel: last math d071c000 last altivec 0000000=
0
Mar  2 22:57:14 localhost kernel: GPR00: 00000000 CD161E00 CD160000 C091A=
700 00000000 00036000 CD55C000 C0518090=20
Mar  2 22:57:14 localhost kernel: GPR08: C02E0000 FFFFFFFF C091A75C C02E0=
000 80004044 10020C68 10010000 00000000=20
Mar  2 22:57:14 localhost kernel: GPR16: 0FC79000 10079000 D02C0100 CEFAB=
520 0FCAF000 C02E0000 C02E0000 0FCAF000=20
Mar  2 22:57:14 localhost kernel: GPR24: 10079000 D02C0100 00000001 00036=
000 00009000 00000000 C091A700 00000084=20
Mar  2 22:57:14 localhost kernel: Call backtrace:=20
Mar  2 22:57:14 localhost kernel: C0031790 C00323EC C0032A50 C0024FFC C00=
25464 C002836C C0013FD8=20
Mar  2 22:57:14 localhost kernel: C0019668 C0019870 C000431C 0ED21E18 100=
04CAC 10005A5C 1000601C=20
Mar  2 22:57:14 localhost kernel: 10007418 0ED0AD30 00000000=20
Warning (Oops_read): Code line not seen, dumping what data is available

>>NIP; c0031908 <__free_pages_ok+1a0/3d0>   <=3D=3D=3D=3D=3D
Trace; c0031790 <__free_pages_ok+28/3d0>
Trace; c00323ec <__free_pages+38/48>
Trace; c0032a50 <free_page_and_swap_cache+64/78>
Trace; c0024ffc <__free_pte+5c/70>
Trace; c0025464 <zap_page_range+1a4/258>
Trace; c002836c <exit_mmap+f0/170>
Trace; c0013fd8 <mmput+74/ac>
Trace; c0019668 <do_exit+e0/2ac>
Trace; c0019870 <sys_wait4+0/39c>
Trace; c000431c <ret_from_syscall_1+0/b4>
Trace; 0ed21e18 Before first symbol
Trace; 10004cac Before first symbol
Trace; 10005a5c Before first symbol
Trace; 1000601c Before first symbol
Trace; 10007418 Before first symbol
Trace; 0ed0ad30 Before first symbol
Trace; 00000000 Before first symbol


4 warnings issued.  Results may not be reliable.

--------------Boundary-00=_Z9MECURYTHYYHCF1TYJA--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
