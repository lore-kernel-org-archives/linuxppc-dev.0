Return-Path: <mail4mz@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.185])
	by ozlabs.org (Postfix) with ESMTP id 97AD0DDE9E
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 06:53:05 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id f5so25718rvb
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 13:53:04 -0700 (PDT)
Message-ID: <5c9cd53b0708151353u67e10e03lf12c3971e4f3d63@mail.gmail.com>
Date: Wed, 15 Aug 2007 16:53:03 -0400
From: "mike zheng" <mail4mz@gmail.com>
To: "Becky Bruce" <becky.bruce@freescale.com>
Subject: Re: System crash on boot_e500.S
In-Reply-To: <16A6A248-880E-483A-AFDD-2A225F4B6864@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5860_25769611.1187211183878"
References: <5c9cd53b0708141314o57440c62waffb4cca3f2be0b9@mail.gmail.com>
	<1187124014.32650.80.camel@ld0161-tx32>
	<5c9cd53b0708150657k71531bdbl848375d5d80faf21@mail.gmail.com>
	<20070815160254.GA9049@ld0162-tx32.am.freescale.net>
	<A9A39446-A8B0-44D7-ABF4-E9918FCC2843@kernel.crashing.org>
	<16A6A248-880E-483A-AFDD-2A225F4B6864@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_5860_25769611.1187211183878
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Unfortunately, all the applications are running on 2.4 kernel. I can not
just throw the 2.4 kernel. I took the some core specific code from
ppc.bkbits.net, such as head_e500.S and mpc85xx_cds_common.c. I assume the
image should work on the 8548 CDS board, or at least for the bootup. I shall
able to have the serial port working in platform_init(). However , the
code stops in the head_e500.S. This does not make any sense. Please correct
me if I am wrong.

BTW, I am using the tool-chain gcc-3_4-e5000glibc-2.3.4-dp, which is from
Freescale for the 8548 CDS BSP of 2.6 kernel.

Any suggest or comment is welcome, I am struggling with this issue for
almost one week...... :-(


On 8/15/07, Becky Bruce <becky.bruce@freescale.com> wrote:
>
>
> On Aug 15, 2007, at 11:28 AM, Kumar Gala wrote:
>
> >
> > On Aug 15, 2007, at 11:02 AM, Scott Wood wrote:
> >
> >> On Wed, Aug 15, 2007 at 09:57:59AM -0400, mike zheng wrote:
> >>> Did you done similar work before? Current 2.6 code need many other
> >>> files,  I
> >>> have following errors when I try to use the head_e500.S from 2.6
> >>> code:
> >>>
> >>>
> >>> /kernel->   powerpc-linux-gnuspe-gcc -m32 -Wp,-MD,arch/ppc/
> >>> kernel/.entry.o.d
> >>> -nostdinc -isystem /opt/mtwk/usr/local/gcc-3_4-
> >>> e500-glibc-2.3.4-dp/powerpc-linux-gnuspe/lib/gcc/powerpc-linux-
> >>> gnuspe/3.4.3/include
> >>> -D__KERNEL__ -Iinclude  -Iarch/ppc -D__ASSEMBLY__ -Iarch/ppc -Wa,-
> >>> me500     -c
> >>> -o arch/ppc/kernel/entry.o arch/ppc/kernel/entry.S
> >>> arch/ppc/kernel/entry.S: Assembler messages:
> >>>
> >>> entry.S:819: Error: unsupported relocation against CSRR0
> >>> entry.S:820: Error: unsupported relocation against CSRR1
> >>> entry.S:888: Error: unsupported relocation against MCSRR0
> >>> entry.S:889: Error: unsupported relocation against MCSRR1
> >>> entry.S:909: Error: unsupported relocation against CSRR0
> >>> entry.S:911: Error: unsupported relocation against CSRR1
> >>
> >> Try arch/powerpc; arch/ppc is deprecated.
> >
> > He's trying a 2.4 kernel.
>
> I think maybe he misunderstood Jon's advive to "use 2.6" as using
> just some files from 2.6.  I think the above is probably some strange
> mix of 2.4 and 2.6, which, of course, won't work.
>
> Jon's real advice was "use 2.6", as in, the whole thing.
>
> -B
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>

------=_Part_5860_25769611.1187211183878
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Unfortunately, all the applications are running on 2.4 kernel. I can not just throw the 2.4 kernel. I took the some core specific code from <a href="http://ppc.bkbits.net">ppc.bkbits.net</a>, such as head_e500.S and mpc85xx_cds_common.c. I assume the image should work on the 8548 CDS board, or at least for the bootup. I shall able to have the serial port working in platform_init(). However , the code&nbsp;stops in the head_e500.S. This does not make any sense. Please correct me if I am wrong.
</div>
<div>&nbsp;</div>
<div>BTW, I am using the tool-chain gcc-3_4-e5000glibc-2.3.4-dp, which is from Freescale for the 8548 CDS BSP of 2.6 kernel. </div>
<div>&nbsp;</div>
<div>Any suggest or comment is welcome, I am struggling with this issue for almost one week...... :-(<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 8/15/07, <b class="gmail_sendername">Becky Bruce</b> &lt;<a href="mailto:becky.bruce@freescale.com">becky.bruce@freescale.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><br>On Aug 15, 2007, at 11:28 AM, Kumar Gala wrote:<br><br>&gt;<br>&gt; On Aug 15, 2007, at 11:02 AM, Scott Wood wrote:
<br>&gt;<br>&gt;&gt; On Wed, Aug 15, 2007 at 09:57:59AM -0400, mike zheng wrote:<br>&gt;&gt;&gt; Did you done similar work before? Current 2.6 code need many other<br>&gt;&gt;&gt; files,&nbsp;&nbsp;I<br>&gt;&gt;&gt; have following errors when I try to use the head_e500.S from 
2.6<br>&gt;&gt;&gt; code:<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; /kernel-&gt;&nbsp;&nbsp; powerpc-linux-gnuspe-gcc -m32 -Wp,-MD,arch/ppc/<br>&gt;&gt;&gt; kernel/.entry.o.d<br>&gt;&gt;&gt; -nostdinc -isystem /opt/mtwk/usr/local/gcc-3_4-
<br>&gt;&gt;&gt; e500-glibc-2.3.4-dp/powerpc-linux-gnuspe/lib/gcc/powerpc-linux-<br>&gt;&gt;&gt; gnuspe/3.4.3/include<br>&gt;&gt;&gt; -D__KERNEL__ -Iinclude&nbsp;&nbsp;-Iarch/ppc -D__ASSEMBLY__ -Iarch/ppc -Wa,-<br>&gt;&gt;&gt; me500&nbsp;&nbsp;&nbsp;&nbsp; -c
<br>&gt;&gt;&gt; -o arch/ppc/kernel/entry.o arch/ppc/kernel/entry.S<br>&gt;&gt;&gt; arch/ppc/kernel/entry.S: Assembler messages:<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; entry.S:819: Error: unsupported relocation against CSRR0<br>
&gt;&gt;&gt; entry.S:820: Error: unsupported relocation against CSRR1<br>&gt;&gt;&gt; entry.S:888: Error: unsupported relocation against MCSRR0<br>&gt;&gt;&gt; entry.S:889: Error: unsupported relocation against MCSRR1<br>
&gt;&gt;&gt; entry.S:909: Error: unsupported relocation against CSRR0<br>&gt;&gt;&gt; entry.S:911: Error: unsupported relocation against CSRR1<br>&gt;&gt;<br>&gt;&gt; Try arch/powerpc; arch/ppc is deprecated.<br>&gt;<br>&gt; He&#39;s trying a 
2.4 kernel.<br><br>I think maybe he misunderstood Jon&#39;s advive to &quot;use 2.6&quot; as using<br>just some files from 2.6.&nbsp;&nbsp;I think the above is probably some strange<br>mix of 2.4 and 2.6, which, of course, won&#39;t work.
<br><br>Jon&#39;s real advice was &quot;use 2.6&quot;, as in, the whole thing.<br><br>-B<br>_______________________________________________<br>Linuxppc-dev mailing list<br><a href="mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org
</a><br><a href="https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br></blockquote></div><br>

------=_Part_5860_25769611.1187211183878--
