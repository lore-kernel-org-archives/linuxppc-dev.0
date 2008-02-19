Return-Path: <m.louvel@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.189])
	by ozlabs.org (Postfix) with ESMTP id B327BDDF66
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 03:38:58 +1100 (EST)
Received: by ti-out-0910.google.com with SMTP id y6so964756tia.13
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Feb 2008 08:38:56 -0800 (PST)
Message-ID: <dda529d0802190838h7c72b590gc6b26ed868bac8e5@mail.gmail.com>
Date: Tue, 19 Feb 2008 16:38:52 +0000
From: "maxime louvel" <m.louvel@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: 2.6.24 for mpc8458amc
In-Reply-To: <47BAEE3F.2070209@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_10121_22661371.1203439135806"
References: <dda529d0802190359r526dc959y8117185e1834e9f4@mail.gmail.com>
	<47BAE6B3.7090000@freescale.com>
	<dda529d0802190642n56ef7fbcx988ce8825bd315da@mail.gmail.com>
	<47BAEE3F.2070209@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_10121_22661371.1203439135806
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi again,

this time I have tried to compile the kernel, with an embedded compiler on
the board.
here is the result...

....
  BOOTAS  arch/powerpc/boot/ps3-hvcall.o
  BOOTCC  arch/powerpc/boot/ps3.o
  BOOTCC  arch/powerpc/boot/treeboot-bamboo.o
  BOOTCC  arch/powerpc/boot/cuboot-8xx.o
  BOOTCC  arch/powerpc/boot/cuboot-pq2.o
  BOOTCC  arch/powerpc/boot/cuboot-sequoia.o
  BOOTCC  arch/powerpc/boot/treeboot-walnut.o
Assembler messages:
Error: Internal assembler error for instruction icbt
Internal error, aborting at ../../gas/config/tc-ppc.c line 1300 in
ppc_setup_opcodes
Please report this bug.
make[2]: *** [arch/powerpc/boot/treeboot-walnut.o] Error 2
make[1]: *** [uImage] Error 2
make: *** [sub-make] Error 2

any idea ?

cheers,
Maxime

On Feb 19, 2008 2:57 PM, Jon Loeliger <jdl@freescale.com> wrote:

> maxime louvel wrote:
> > Thanks for your answer,
> >
> > I am going to check this ppc / powerpc things.
> > I should use the architecture powerpc, don't I?
>
> ARCH == ppc is scheduled for _removal_ from the
> entire Kernel source base is just about 4 months.
> Feel free to move the deck chairs around. :-)
>
> > I'm not really sure I have understand what do you want to do with a
> > BDI-2000.
>
> Perhaps, for starters, you read "Building Embedded Linux Systems"
> as found here:
>    http://www.oreilly.com/catalog/belinuxsys/
>
> > I access the cards through a serial line directly.
>
> Of course.  But when you get no information there,
> you might try a different interface.
>
> jdl
>



-- 
Maxime Louvel
0044 7964 5555 80
43 Allen road
Whitemore reans
WV60AW Wolverhampton
United Kingdom

------=_Part_10121_22661371.1203439135806
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi again,<br><br>this time I have tried to compile the kernel, with an embedded compiler on the board.<br>here is the result...<br><br>....<br>&nbsp; BOOTAS&nbsp; arch/powerpc/boot/ps3-hvcall.o<br>&nbsp; BOOTCC&nbsp; arch/powerpc/boot/ps3.o<br>
&nbsp; BOOTCC&nbsp; arch/powerpc/boot/treeboot-bamboo.o<br>&nbsp; BOOTCC&nbsp; arch/powerpc/boot/cuboot-8xx.o<br>&nbsp; BOOTCC&nbsp; arch/powerpc/boot/cuboot-pq2.o<br>&nbsp; BOOTCC&nbsp; arch/powerpc/boot/cuboot-sequoia.o<br>&nbsp; BOOTCC&nbsp; arch/powerpc/boot/treeboot-walnut.o<br>
Assembler messages:<br>Error: Internal assembler error for instruction icbt<br>Internal error, aborting at ../../gas/config/tc-ppc.c line 1300 in ppc_setup_opcodes<br>Please report this bug.<br>make[2]: *** [arch/powerpc/boot/treeboot-walnut.o] Error 2<br>
make[1]: *** [uImage] Error 2<br>make: *** [sub-make] Error 2<br><br>any idea ?<br><br>cheers,<br>Maxime<br><br><div class="gmail_quote">On Feb 19, 2008 2:57 PM, Jon Loeliger &lt;<a href="mailto:jdl@freescale.com">jdl@freescale.com</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d">maxime louvel wrote:<br>&gt; Thanks for your answer,<br>&gt;<br>&gt; I am going to check this ppc / powerpc things.<br>
&gt; I should use the architecture powerpc, don&#39;t I?<br><br></div>ARCH == ppc is scheduled for _removal_ from the<br>entire Kernel source base is just about 4 months.<br>Feel free to move the deck chairs around. :-)<br>
<div class="Ih2E3d"><br>&gt; I&#39;m not really sure I have understand what do you want to do with a<br>&gt; BDI-2000.<br><br></div>Perhaps, for starters, you read &quot;Building Embedded Linux Systems&quot;<br>as found here:<br>
 &nbsp; &nbsp;<a href="http://www.oreilly.com/catalog/belinuxsys/" target="_blank">http://www.oreilly.com/catalog/belinuxsys/</a><br><div class="Ih2E3d"><br>&gt; I access the cards through a serial line directly.<br><br></div>Of course. &nbsp;But when you get no information there,<br>
you might try a different interface.<br><br>jdl<br></blockquote></div><br><br clear="all"><br>-- <br>Maxime Louvel<br>0044 7964 5555 80<br>43 Allen road<br>Whitemore reans<br>WV60AW Wolverhampton<br>United Kingdom

------=_Part_10121_22661371.1203439135806--
