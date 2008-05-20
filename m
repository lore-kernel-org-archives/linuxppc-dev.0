Return-Path: <jmarc007@yahoo.com>
Received: from n61.bullet.mail.sp1.yahoo.com (n61.bullet.mail.sp1.yahoo.com
	[98.136.44.37]) by ozlabs.org (Postfix) with SMTP id D418FDE8D0
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 01:56:13 +1000 (EST)
Date: Tue, 20 May 2008 08:56:12 -0700 (PDT)
From: John Marc <jmarc007@yahoo.com>
Subject: Re: USB on MPC8641D
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <844633.35330.qm@web46011.mail.sp1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/html; charset=us-ascii
Message-ID: <244870.53526.qm@web46001.mail.sp1.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: jmarc007@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

<table cellspacing='0' cellpadding='0' border='0' ><tr><td style='font: inherit;'><P>Hi Mr Kumar</P>
<P>Sorry for replying so late. </P>
<P>I have tested the USB on the linux kernel 2.6.25 , but its not working.</P>
<P>&nbsp;</P>
<P>Please suggest, Is this beacause of the PCI-Express Bug ??</P>
<P>&nbsp;</P>
<P>With Regards</P>
<P>John<BR><BR>--- On <B>Thu, 4/17/08, John Marc <I>&lt;jmarc007@yahoo.com&gt;</I></B> wrote:<BR></P>
<BLOCKQUOTE style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: rgb(16,16,255) 2px solid">From: John Marc &lt;jmarc007@yahoo.com&gt;<BR>Subject: Re: USB on MPC8641D<BR>To: "Kumar Gala" &lt;galak@kernel.crashing.org&gt;<BR>Cc: linuxppc-dev@ozlabs.org<BR>Date: Thursday, April 17, 2008, 5:53 PM<BR><BR>
<DIV id=yiv226006487>
<DIV>Okie Friend ,</DIV>
<DIV>I will try the latest kernel 2.6.24, and let you know the results.</DIV>
<DIV>&nbsp;</DIV>
<DIV>With Regards</DIV>
<DIV>John<BR><BR><B><I>Kumar Gala &lt;galak@kernel.crashing.org&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid"><BR>On Apr 17, 2008, at 3:36 AM, John Marc wrote:<BR>&gt; Hi<BR>&gt; I Have the kernel patches , but no one for the USB.<BR>&gt; The changes for the USB are integrated in the Kernel.<BR>&gt; I am currently looking into the linux BSP for usb<BR>&gt; changes , but unfortunately don't find any major<BR>&gt; chages.<BR>&gt;<BR>&gt; MPC8641 board have one EHCI controller and 3 OHCI<BR>&gt; conroller.<BR>&gt;<BR>&gt; As I am also new to USB , it would be great help, if<BR>&gt; someone give me any idea about the changes in new<BR>&gt; MPC8641 BSP ?<BR>&gt;<BR>&gt; Does freescale fix the PCI Express issue , that makes<BR>&gt; USB works.<BR>&gt;<BR>&gt; I have lots of hope with this forum :-)<BR>&gt;<BR>&gt;<BR>&gt; With Regards<BR>&gt; John<BR><BR>This forum is about the open source kernel and not BSPs kernels from <BR>Freescale or any other provider.<BR><BR>Have
 you tried a 2.6.24 or 2.6.25 open source kernel for the 8641 and <BR>see if it works w/regards to USB. If not we can help try and figure <BR>out why not.<BR><BR>There have been a number of fixes made to PCIe support on 8641 that <BR>are in the 2.6.24 kernel, I'm guessing some of those might address <BR>whatever issue you're seeing with USB.<BR><BR>- k<BR></BLOCKQUOTE><BR>
<P>
<HR SIZE=1>
Be a better friend, newshound, and know-it-all with Yahoo! Mobile. <A href="http://us.rd.yahoo.com/evt=51733/*http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ" target=_blank rel=nofollow>Try it now.</A></DIV><PRE>_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev</PRE></BLOCKQUOTE></td></tr></table><br>

      
