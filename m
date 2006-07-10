Return-Path: <gturnock@ivhs.com>
Received: from postfix.fpelectronics.com (gw.ivhs.com [66.46.242.98])
	by ozlabs.org (Postfix) with ESMTP id 17EAF67B60
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Jul 2006 23:45:30 +1000 (EST)
Subject: Re: MPC5200 boot giving "request_module: runaway loop
	modprobe	binfmt-4c46" errors
MIME-Version: 1.0
From: gturnock@ivhs.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 10 Jul 2006 09:48:34 -0400
Message-ID: <OF2410ED27.EB33683B-ON852571A7.004BDB70-852571A7.004BDB94@fpelectronics.com>
MIME-Version: 1.0
Content-Type: text/html;
	charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org, gturnock@ivhs.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

<FONT face=3D"Default Sans Serif,Verdana,Arial,Helvetica,sans-serif" size=
=3D2><DIV><DIV><DIV>Hi Ben,</DIV><DIV>&nbsp;</DIV><DIV>Thanks for your ques=
tion... As far as I can tell... Yes ;).&nbsp; The board is a LITE5200 Evalu=
ation board from Freescale.&nbsp; I am, however, booting from an x86 host r=
unning FC5.&nbsp; Now having said that, I have taken (what I think) are all=
 the proper steps to cross compile all the necessary bits (kernel modules, =
busybox, tinylogin, etc)... Hmm something I've missed perhaps?</DIV><DIV>&n=
bsp;</DIV><DIV>Cheers</DIV><DIV>Glenn.</DIV><DIV><BR>&nbsp;</DIV><FONT colo=
r=3D#990099>-----Benjamin Herrenschmidt &lt;benh@kernel.crashing.org&gt; wr=
ote: -----<BR><BR></FONT><blockquote style=3D"PADDING-RIGHT: 0px; PADDING-L=
EFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0=
px">To: gturnock@ivhs.com<BR>From: Benjamin Herrenschmidt &lt;benh@kernel.c=
rashing.org&gt;<BR>Date: 07/09/2006 08:31AM<BR>cc: linuxppc-embedded@ozlabs=
.org<BR>Subject: Re: MPC5200 boot giving "request=5Fmodule: runaway loop mo=
dprobe	binfmt-4c46" errors<BR><BR><FONT face=3Dmonospace size=3D2>On Fri, 2=
006-07-07 at 18:15 -0400, gturnock@ivhs.com wrote:<BR>&gt; Hi All,<BR>&gt; =
<BR>&gt; I am currently attempting to get the 2.6 Linux Kernel<BR>&gt; ( Sy=
lvain's Kernel from<BR>&gt; <A href=3D"http://gitbits.246tnt.com/gitbits/li=
nux-2.6-mpc52xx.git" target=3Dblank  >http://gitbits.246tNt.com/gitbits/lin=
ux-2.6-mpc52xx.git</A>) &nbsp;booting over<BR>&gt; NFS on a Freescale LITE5=
200 board. &nbsp;At present, I have been able to<BR>&gt; successfully mount=
 the rootfs over NFS, but am encountering the<BR>&gt; following issue... <B=
R>&gt; <BR>&gt; After the kernel frees the unused memory after the NFS moun=
t, I get a<BR>&gt; string of <BR>&gt; <BR>&gt; request=5Fmodule: runaway lo=
op modprobe binfmt-4c46<BR>&gt; <BR>&gt; errors and the console appears to =
hang. &nbsp;Any help would be greatly<BR>&gt; appreciated!<BR><BR>Are you s=
ure you are trying to boot a ppc NFS root ? :) Looks to me like<BR>you are =
trying to boot an x86 one...<BR><BR>Ben.<BR><BR><BR></FONT></blockquote><br=
></DIV></DIV></FONT>=
