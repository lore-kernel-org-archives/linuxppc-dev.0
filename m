Subject: Re: 2.6.0-test5 "incorrect section attributes for .plt"
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Cliff White <cliffw@osdl.org>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200309192258.h8JMwWs04059@mail.osdl.org>
References: <200309192258.h8JMwWs04059@mail.osdl.org>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1064060622.1347.45.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Date: Sat, 20 Sep 2003 14:23:42 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2003-09-20 at 00:58, Cliff White wrote:
> System is an iBook2,
> distro is Debian unstable
> kernel is 2.6.0-test5 or current from
> bk://ppc.bkbits.net/linuxppc-2.5
>
> gcc version 3.3.2 20030908 (Debian prerelease)
>
> When compiling modules, i get this warning, repeatedly:
>  CC [M]  sound/ppc/pmac.o
> {standard input}: Assembler messages:
> {standard input}:3: Warning: setting incorrect section attributes for .plt
>
> Then, this failure:
>
>   AS      arch/ppc/boot/common//util.o
> arch/ppc/boot/common/util.S: Assembler messages:
> arch/ppc/boot/common/util.S:220: Warning: setting incorrect section attributes
> for .relocate_code
> arch/ppc/boot/common//util.o: File truncated
> arch/ppc/boot/common/util.S:281: FATAL: Can't write
> arch/ppc/boot/common//util.o: File truncated
> make[2]: *** [arch/ppc/boot/common//util.o] Error 1
> make[1]: *** [arch/ppc/boot/common/] Error 2

See http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=211668 .


--
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
