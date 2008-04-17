Return-Path: <jmarc007@yahoo.com>
Received: from n57.bullet.mail.sp1.yahoo.com (n57.bullet.mail.sp1.yahoo.com
	[98.136.44.49]) by ozlabs.org (Postfix) with SMTP id 57FD3DE046
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 03:59:19 +1000 (EST)
Date: Thu, 17 Apr 2008 10:53:27 -0700 (PDT)
From: John Marc <jmarc007@yahoo.com>
Subject: Re: USB on MPC8641D
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1492DA11-D49C-492A-9085-3B5A7A569245@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-467081140-1208454807=:35330"
Message-ID: <844633.35330.qm@web46011.mail.sp1.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-467081140-1208454807=:35330
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Okie Friend ,
  I will try the latest kernel 2.6.24, and let you know the results.
   
  With Regards
  John

Kumar Gala <galak@kernel.crashing.org> wrote:
  
On Apr 17, 2008, at 3:36 AM, John Marc wrote:
> Hi
> I Have the kernel patches , but no one for the USB.
> The changes for the USB are integrated in the Kernel.
> I am currently looking into the linux BSP for usb
> changes , but unfortunately don't find any major
> chages.
>
> MPC8641 board have one EHCI controller and 3 OHCI
> conroller.
>
> As I am also new to USB , it would be great help, if
> someone give me any idea about the changes in new
> MPC8641 BSP ?
>
> Does freescale fix the PCI Express issue , that makes
> USB works.
>
> I have lots of hope with this forum :-)
>
>
> With Regards
> John

This forum is about the open source kernel and not BSPs kernels from 
Freescale or any other provider.

Have you tried a 2.6.24 or 2.6.25 open source kernel for the 8641 and 
see if it works w/regards to USB. If not we can help try and figure 
out why not.

There have been a number of fixes made to PCIe support on 8641 that 
are in the 2.6.24 kernel, I'm guessing some of those might address 
whatever issue you're seeing with USB.

- k


       
---------------------------------
Be a better friend, newshound, and know-it-all with Yahoo! Mobile.  Try it now.
--0-467081140-1208454807=:35330
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Okie Friend ,</div>  <div>I will try the latest kernel 2.6.24, and let you know the results.</div>  <div>&nbsp;</div>  <div>With Regards</div>  <div>John<BR><BR><B><I>Kumar Gala &lt;galak@kernel.crashing.org&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid"><BR>On Apr 17, 2008, at 3:36 AM, John Marc wrote:<BR>&gt; Hi<BR>&gt; I Have the kernel patches , but no one for the USB.<BR>&gt; The changes for the USB are integrated in the Kernel.<BR>&gt; I am currently looking into the linux BSP for usb<BR>&gt; changes , but unfortunately don't find any major<BR>&gt; chages.<BR>&gt;<BR>&gt; MPC8641 board have one EHCI controller and 3 OHCI<BR>&gt; conroller.<BR>&gt;<BR>&gt; As I am also new to USB , it would be great help, if<BR>&gt; someone give me any idea about the changes in new<BR>&gt; MPC8641 BSP ?<BR>&gt;<BR>&gt; Does freescale fix the PCI Express issue , that makes<BR>&gt; USB
 works.<BR>&gt;<BR>&gt; I have lots of hope with this forum :-)<BR>&gt;<BR>&gt;<BR>&gt; With Regards<BR>&gt; John<BR><BR>This forum is about the open source kernel and not BSPs kernels from <BR>Freescale or any other provider.<BR><BR>Have you tried a 2.6.24 or 2.6.25 open source kernel for the 8641 and <BR>see if it works w/regards to USB. If not we can help try and figure <BR>out why not.<BR><BR>There have been a number of fixes made to PCIe support on 8641 that <BR>are in the 2.6.24 kernel, I'm guessing some of those might address <BR>whatever issue you're seeing with USB.<BR><BR>- k<BR></BLOCKQUOTE><BR><p>&#32;

      <hr size=1>Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile. <a href="http://us.rd.yahoo.com/evt=51733/*http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ "> Try it now.</a>
--0-467081140-1208454807=:35330--
