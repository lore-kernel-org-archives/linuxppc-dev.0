Return-Path: <rpjday@mindspring.com>
Received: from scaup.mail.pas.earthlink.net (scaup.mail.pas.earthlink.net
	[207.217.120.49]) by ozlabs.org (Postfix) with ESMTP id 6F3932BDB3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Sep 2004 03:27:53 +1000 (EST)
Date: Tue, 28 Sep 2004 13:21:16 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20040928152214.CC499C1430@atlas.denx.de>
Message-ID: <Pine.LNX.4.60.0409281317590.11302@localhost.localdomain>
References: <20040928152214.CC499C1430@atlas.denx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: I2C/SPI/SMC relocation patch works for both SMC 1 and 2? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 28 Sep 2004, Wolfgang Denk wrote:

> In message <Pine.LNX.4.60.0409280836340.9825@localhost.localdomain> you wrote:
>>
>>    but the PDF file doesn't refer explicitly to SMC1, just to the
>> generic SMC(UART).  does this mean that the same instructions to
>
> It relates to the SMC which parameter RAM  location  is  in  conflict
> with the SPI/I2C parameter RAM, i. e. SMC1.

huh?  what does SMC1 relocation have to do with either of I2C or SPI? 
i'm looking at the PRAM memory map right now, and whether or not you 
choose to relocate SMC1 seems independent from whether you choose to 
relocate both (or either) of I2C or SPI.

i don't see how SMC1 can be "in conflict with the SPI/I2C parameter 
RAM" as you claim.  can you explain that?

rday
