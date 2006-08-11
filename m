Return-Path: <benjamin.heyne@uni-dortmund.de>
Received: from unimail.uni-dortmund.de (mx1.HRZ.Uni-Dortmund.DE
	[129.217.128.51]) by ozlabs.org (Postfix) with ESMTP id 9622467B69
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 18:31:01 +1000 (EST)
Received: from bob.dt.e-technik.uni-dortmund.de
	(bob.dt.e-technik.Uni-Dortmund.DE [129.217.163.29])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.13.7/8.13.7) with ESMTP id k7B8USTa024404
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 10:30:33 +0200 (CEST)
Date: Fri, 11 Aug 2006 10:30:27 +0200
From: Benjamin Heyne <benjamin.heyne@uni-dortmund.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: XUPV2P, which kernel 2.6. device drivers are available?
Message-ID: <20060811103027.2528a8e5@bob.dt.e-technik.uni-dortmund.de>
In-Reply-To: <44D7644A.5070107@gmail.com>
References: <20060801100220.26176938@bob.dt.e-technik.uni-dortmund.de>
	<20060807172251.1d4e81bd@bob.dt.e-technik.uni-dortmund.de>
	<44D7644A.5070107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

And so it came to pass, that on Mon, 07 Aug 2006 17:03:22 +0100
Ameet Patil <ammubhai@gmail.com> wrote as thus:

> Hi Benjamin,
>     I had ported the ENET driver but it was a bit buggy. Could you send 
> me your driver patch so I can test it?
> 

Hi,
I have put all necessary files into an archive. I have implemented
the driver into a patched version of the 2.6.18-rc3 kernel, so
I thought it would be the best to provide all modified files in an
archive (also, I am not familiar with generating patches and stuff... ;-).
Please feel free to provide a "real" patch.

Ok, here we go:

http://www.dt.e-technik.uni-dortmund.de/mitarbeiter/heyne/xilinx/xilinx_emac_26.zip

Be warned:
This driver probably can be considered as BadHack(TM) -
It's the first one I am providing to the public. So if
you have any suggestions for improving it, please tell me.

TODO (As far as I can tell):
	- Make it a real platform device
	- Make use of the XILINX_EDK config of the TEMAC driver patch
	  (Btw.: Will this be officially integrated into the kernel?).

Any feedback will be appreciated...

Best regards
-- 
Benjamin Heyne
