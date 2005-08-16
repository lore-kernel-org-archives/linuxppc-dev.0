Return-Path: <kjoutwater@raytheon.com>
Received: from bos-gate2.raytheon.com (bos-gate2.raytheon.com [199.46.198.231])
	by ozlabs.org (Postfix) with ESMTP id 13B1967F67
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Aug 2005 02:22:12 +1000 (EST)
In-Reply-To: <4301686E.6020904@xilinx.com>
To: Peter Ryser <peter.ryser@xilinx.com>
MIME-Version: 1.0
From: Keith J Outwater <kjoutwater@raytheon.com>
Message-ID: <OF420A7A65.554F5D8B-ON0725705F.00572C9A-0725705F.00575400@mck.us.ray.com>
Date: Tue, 16 Aug 2005 08:53:51 -0700
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Best kernel for Xilinx VirtexII Pro/PPC405 ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Peter -
Yes, I have looked at both xapp765 and xapp542.  In order to get the 
kernel source mentioned in the app note, I have to get the Monta Vista 
preview kit and get it installed.  The preview kit will not install under 
Fedora Core 4 - the encryption stuff is broken (and the fix in the Monta 
Vista FAQ does not work).
 I am running all of my development tools (EDK, ISE, ELDK, etc...) under 
Fedora Core 4, so I am looking for a publicly accessible kernel source 
tree that best supports the PPC405 in the Virtex II Pro.

Keith

Peter Ryser <peter.ryser@xilinx.com> wrote on 08/15/2005 09:15:42 PM:

> You might want to look at Xilinx Application Note 765 (XAPP765, 
> http://www.xilinx.com/bvdocs/appnotes/xapp765.pdf) for some instructions 

> on how to get started with EDK and Linux. All source is published in 
> linuxppc-2.4.
> 
> - Peter
> 
> 
> Keith J Outwater wrote:
> 
> >Hello all - 
> >I am designing an embedded system using a Xilinx Virtex II Pro FPGA.
> >Can anyone point me to the "best" kernel source tree to use ?
> >"Best" in this case means:
> >1. A 2.4 series kernel with good support for Xilinx peripheral devices 
> >(existing Xilinx ML300 support is fine).
> >2. Good stability
> >
> >By default I'll use the Montavista linuxppc_2.4 tree unless there is a 
> >better choice out there.
> >
> >Thanks!
> >
> >Keith
> >_______________________________________________
> >Linuxppc-embedded mailing list
> >Linuxppc-embedded@ozlabs.org
> >https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> >
> > 
> >
> 
> 
> 
