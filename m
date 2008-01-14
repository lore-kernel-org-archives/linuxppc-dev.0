Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id A02EBDDE20
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 07:04:45 +1100 (EST)
Message-ID: <478BC05C.2080007@pikatech.com>
Date: Mon, 14 Jan 2008 15:04:44 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] MTD for Taco
References: <477F12D1.2070109@pikatech.com>
	<20080114024432.1dcba2f7@vader.jdub.homelinux.org>
	<478B9CB6.7000408@pikatech.com> <200801142042.56847.sr@denx.de>
In-Reply-To: <200801142042.56847.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
> And the EBC0_BxCR & EBC0BxAP registers for the CS where the NAND is connected? 
> How are they configured?
>   
EBC0_B1CR d001c000
EBC0_B1AP 18003c0

Which matches the defines in include/configs/warp.h:

    #define CFG_EBC_PB1AP        0x018003c0
    #define CFG_EBC_PB1CR        (CFG_NAND_ADDR | 0x1c000)

It also matches the defines in sequoia.h except that we are on CS1 and 
the sequoia is on CS3.

Cheers,
   Sean
