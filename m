Return-Path: <ammubhai@gmail.com>
Received: from mailgw.cs.york.ac.uk (mailgw.cs.york.ac.uk [144.32.40.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F27F467B32
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Aug 2006 02:04:01 +1000 (EST)
Message-ID: <44D7644A.5070107@gmail.com>
Date: Mon, 07 Aug 2006 17:03:22 +0100
From: Ameet Patil <ammubhai@gmail.com>
MIME-Version: 1.0
To: Benjamin Heyne <benjamin.heyne@uni-dortmund.de>
Subject: Re: XUPV2P, which kernel 2.6. device drivers are available?
References: <20060801100220.26176938@bob.dt.e-technik.uni-dortmund.de>
	<20060807172251.1d4e81bd@bob.dt.e-technik.uni-dortmund.de>
In-Reply-To: <20060807172251.1d4e81bd@bob.dt.e-technik.uni-dortmund.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Benjamin,
    I had ported the ENET driver but it was a bit buggy. Could you send 
me your driver patch so I can test it?

Thanks,
-Ameet

Benjamin Heyne wrote:
> Hi all,
> despite having problems with zlib, I'd like to know which
> device drivers for the XUPV2P have already been ported
> to the 2.6 kernel? - I don't want to do work twice ;-).
> 
> For practicing, I just ported the original Xilinx ENET 100MBit
> driver (seems to work in FIFO mode, including MII - At least I
> can mount and use a NFS root file system)...but that has probably
> already been done elsewhere. I saw that work is going on for 
> the SystemACE. - So what about VGA, AC97, PS/2, SATA?
> 
> Best regards
> Benjamin Heyne
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
