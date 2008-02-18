Return-Path: <m.louvel@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.185])
	by ozlabs.org (Postfix) with ESMTP id 7226DDDEF5
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 02:46:57 +1100 (EST)
Received: by ti-out-0910.google.com with SMTP id y6so821763tia.13
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 07:46:56 -0800 (PST)
Message-ID: <dda529d0802180746q4d63d4c3i41ff3afe55a0c4b9@mail.gmail.com>
Date: Mon, 18 Feb 2008 15:46:55 +0000
From: "maxime louvel" <m.louvel@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Build failure on treeboot-walnut.c
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5381_22390610.1203349615951"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_5381_22390610.1203349615951
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Kumar Gala wrote:

> $ make V=1

> make ARCH=ppc64 -f scripts/Makefile.build obj=arch/powerpc/boot
> arch/powerpc/boot/uImage powerpc-unknown-linux-gnu-gcc -m32
>- Wp,-MD,arch/powerpc/boot/.treeboot-walnut.o.d -Wall -Wundef
>- Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -Os -msoft-float
-pipe
>- fomit-frame-pointer -fno-builtin -fPIC -nostdinc -isystem
> /_TOOLS_/.dist0/gnu-
gcc-4.0.2-binutils-2.16.1-glibc-2.3.6-e300c2-powerpc-unknown-linux-gnu/i686-
pc-linux2.4/bin/../lib/gcc/powerpc-unknown-linux-gnu/4.0.2/include -
Iarch/powerpc/boot -I/temp/kumar.484/arch/powerpc/boot -mcpu=405 -c -o
> arch/powerpc/boot/treeboot-walnut.o arch/powerpc/boot/treeboot-walnut.c
> Assembler messages:
> Error: Internal assembler error for instruction icbt
> Internal error, aborting at
> /tmp/crosstool/crosstool-0.42/build/powerpc-unknown-linux-gnu/gcc-
4.0.2_e300-enabled-glibc-2.3.6/binutils-2.16.1-complete/gas/config/tc-ppc.c
> line 1314 in ppc_setup_opcodes
> Please report this bug.
> make[1]: *** [arch/powerpc/boot/treeboot-walnut.o] Error 2
> make: *** [uImage] Error 2
>
>ARCH=ppc64?  WTF?  I specifically said ARCH=powerpc on the make command
line.

I have got the exact same problem.
Has the problem been sovled ?

I am trying to compile a 2.6.24 kernel (vanilla + some board specific stuff)
with a vanilla gcc-4.1.2 with the flag -msoft-float.

cheers,
Maxime
-- 
Maxime Louvel
0044 7964 5555 80
43 Allen road
Whitemore reans
WV60AW Wolverhampton
United Kingdom

------=_Part_5381_22390610.1203349615951
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Kumar Gala wrote:<br><br>&gt; $ make V=1<br><br>&gt; make ARCH=ppc64 -f scripts/Makefile.build obj=arch/powerpc/boot <br>&gt; arch/powerpc/boot/uImage powerpc-unknown-linux-gnu-gcc -m32 <br>&gt;- Wp,-MD,arch/powerpc/boot/.treeboot-walnut.o.d -Wall -Wundef <br>
&gt;- Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -Os -msoft-float -pipe <br>&gt;- fomit-frame-pointer -fno-builtin -fPIC -nostdinc -isystem <br>&gt; /_TOOLS_/.dist0/gnu-gcc-4.0.2-binutils-2.16.1-glibc-2.3.6-e300c2-powerpc-unknown-linux-gnu/i686-pc-linux2.4/bin/../lib/gcc/powerpc-unknown-linux-gnu/4.0.2/include - Iarch/powerpc/boot -I/temp/kumar.484/arch/powerpc/boot -mcpu=405 -c -o <br>
&gt; arch/powerpc/boot/treeboot-walnut.o arch/powerpc/boot/treeboot-walnut.c<br>&gt; Assembler messages:<br>&gt; Error: Internal assembler error for instruction icbt<br>&gt; Internal error, aborting at <br>&gt; /tmp/crosstool/crosstool-0.42/build/powerpc-unknown-linux-gnu/gcc-4.0.2_e300-enabled-glibc-2.3.6/binutils-2.16.1-complete/gas/config/tc-ppc.c <br>
&gt; line 1314 in ppc_setup_opcodes<br>&gt; Please report this bug.<br>&gt; make[1]: *** [arch/powerpc/boot/treeboot-walnut.o] Error 2<br>&gt; make: *** [uImage] Error 2<br>&gt; <br>&gt;ARCH=ppc64?&nbsp; WTF?&nbsp; I specifically said ARCH=powerpc on the make command line.<br>
<br>I have got the exact same problem.<br>Has the problem been sovled ?<br><br>I am trying to compile a 2.6.24 kernel (vanilla + some board specific stuff) with a vanilla gcc-4.1.2 with the flag -msoft-float.<br><br>cheers,<br>
Maxime<br>-- <br>Maxime Louvel<br>0044 7964 5555 80<br>43 Allen road<br>Whitemore reans<br>WV60AW Wolverhampton<br>United Kingdom

------=_Part_5381_22390610.1203349615951--
