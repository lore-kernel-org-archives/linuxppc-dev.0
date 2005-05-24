Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id B25E6679F7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 May 2005 19:01:27 +1000 (EST)
Message-ID: <4292ED43.8060607@anagramm.de>
Date: Tue, 24 May 2005 11:00:51 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Alex Zeffertt <ajz@cambridgebroadband.com>
References: <20050523145953.3a2044ef.ajz@cambridgebroadband.com>
In-Reply-To: <20050523145953.3a2044ef.ajz@cambridgebroadband.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linux-atm-general@lists.sourceforge.net"
	<linux-atm-general@lists.sourceforge.net>, linuxppc-embedded@ozlabs.org
Subject: Re: Memory mapping the PHY on CR826
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

FYI: This is a board based on the Freescale MPC8260 processor.

Greets,
Clemens

Alex Zeffertt wrote:
> Hi all,
> 
> Does anyone here have *any* code for memory mapping the PM5350 ATM phy
> on the Microsys CR826 board?
> 
> I've just purchased this board from Microsys and I'm trying to get the
> atm8260 ATM device driver to work on it - unfortunately I cannot seem to
> memory map the phy.  My current settings are:
> 
> 
>   memctl->memc_or8 = 0xe0400ef4; // base 0xe0400000; default timings
>   memctl->memc_br8 = 0xffff8821; // min banksize; 8bit port; GPCM local;
>                                  //  bank valid
> 
> Has anybody done this already?
> 
> TIA,
> 
> Alex
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
