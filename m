Message-ID: <313680C9A886D511A06000204840E1CF08F4303E@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>,
	"'wd@denx.de'" <wd@denx.de>
Cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Seg fault when configuring starting cross-compiling linux-2.6.7 f
	or PPC on Intel platform (windows XP) using cygwin
Date: Tue, 20 Jul 2004 10:14:03 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

We are getting segmentation fault when configuring starting cross-compiling
linux-2.6.7 for PPC on Intel platform (windows XP) using cygwin - any ideas
?

apovolot@USPITLAD104868 ~/linux-2.6.7
$ make menuconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/split-include
  HOSTCC  scripts/basic/docproc
  HOSTLD  scripts/kconfig/mconf
collect2: ld terminated with signal 11 [Segmentation fault], core dumped
scripts/kconfig/libkconfig.so(.text+0x0):crtstuff.c: multiple definition of
`___
do_sjlj_init'
/usr/lib/gcc-lib/i686-pc-cygwin/3.3.1/crtbegin.o(.text+0x0):crtstuff.c:
first defined here
make[1]: *** [scripts/kconfig/mconf] Error 1
make: *** [menuconfig] Error 2

Thanks,
Alex Povolotsky
-----Original Message-----
From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
Sent: Friday, July 09, 2004 11:09 AM
To: Povolotsky, Alexander
Cc: 'linuxppc-dev@lists.linuxppc.org'
Subject: Re: FW: How reliable Linux 2.6 is on PowerPC platform at this
point ?


On Fri, 2004-07-09 at 04:30, Povolotsky, Alexander wrote:
> Hi,
>
> Any takers ?

Should be as reliable as x86 by now ;)

Ben.

> TIA,
> Best Regards,
> Alex Povolotsky
>
> -----Original Message-----
> From: Andrew Morton [mailto:akpm@osdl.org]
> Sent: Friday, July 09, 2004 5:27 AM
> To: Povolotsky, Alexander
> Subject: Re: How reliable Linux 2.6 is on PowerPC platform at this point?
>
> "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com> wrote:
> >
> > Hi Andrew,
> >
> > How reliable Linux 2.6 is on PowerPC platform at this point ?
>
> I suspect it's good if you pick the right release, but I am very much not
> the right person to ask, sorry.
>
> I suggest you ask the folks on linuxppc-dev@lists.linuxppc.org
>
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
