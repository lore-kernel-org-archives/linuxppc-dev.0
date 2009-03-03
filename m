Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 00403DE010
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 08:18:28 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Lec0P-00085G-0B
	for linuxppc-dev@ozlabs.org; Tue, 03 Mar 2009 13:18:25 -0800
Message-ID: <22318178.post@talk.nabble.com>
Date: Tue, 3 Mar 2009 13:18:25 -0800 (PST)
From: Felix Radensky <felix@embedded-sol.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: PPC 405 EX USB Development
In-Reply-To: <200902251345.51880.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <d9c5f2890902250115s3867904fj22e8f5af2d469581@mail.gmail.com>
	<200902251327.02082.sr@denx.de> <200902251345.51880.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>




Stefan Roese wrote:
> 
> On Wednesday 25 February 2009, Stefan Roese wrote:
> 
> 
> You can find a driver for this Synopsys DWC OTG controller in our 
> linux-2.6-denx repository:
> 
> http://git.denx.de/?p=linux-2.6-denx.git;a=tree;f=drivers/usb/gadget/dwc_otg;h=526d515e4764a0c92cebbf909c245d6aec7e198c;hb=HEAD
> 
> But please note that this driver is currently not in shape for mainline 
> inclusion. It's working though, so it should help you while writing a new, 
> clean driver.
> 
> 

Hi, Stefan

Was this driver tested in host-only mode ?
Also, would this be a correct combination of flags for host-only mode 
on 405EX:
KBUILD_CPPFLAGS	+= -Dlinux -DOTG_PLB_DMA -DOTG_PLB_DMA_TASKLET
-DDWC_HOST_ONLY

Thanks a lot.

Felix.
-- 
View this message in context: http://www.nabble.com/PPC-405-EX-USB-Development-tp22201577p22318178.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
