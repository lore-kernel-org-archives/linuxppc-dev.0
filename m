Return-Path: <rpjday@mindspring.com>
Received: from soulshock.mail.pas.earthlink.net
	(soulshock.mail.pas.earthlink.net [207.217.120.130])
	by ozlabs.org (Postfix) with ESMTP id C7AC52BDB3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Sep 2004 22:57:14 +1000 (EST)
Received: from bittern.mail.pas.earthlink.net (bittern.mail.pas.earthlink.net
	[207.217.120.119])
	by soulshock.mail.pas.earthlink.net (8.11.6+Sun/8.11.6) with ESMTP id
	i8SCo7J25698 for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Sep 2004 05:50:07 -0700 (PDT)
Received: from user-0c8hpmb.cable.mindspring.com ([24.136.230.203])
	by bittern.mail.pas.earthlink.net with esmtp (Exim 3.33 #1)
	id 1CCHQg-0007Io-00
	for linuxppc-embedded@ozlabs.org; Tue, 28 Sep 2004 05:50:03 -0700
Date: Tue, 28 Sep 2004 08:43:32 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Message-ID: <Pine.LNX.4.60.0409280836340.9825@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: I2C/SPI/SMC relocation patch works for both SMC 1 and 2?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


   i'm reading the microcode patch PDF doc file describing the 
relocation of I2C/SPI/SMC for the 850.  as i've mentioned, in my case, 
i've relocated *specifically* SMC1 so i can use SCC3 for ethernet and 
it seems to work just fine.

   but the PDF file doesn't refer explicitly to SMC1, just to the 
generic SMC(UART).  does this mean that the same instructions to 
relocate SMC1 could also relocate SMC2 at the same time?  the writeup 
isn't clear on this and, from what i've read, it might be useful to 
relocate SMC2 if one wants to use the reserved memory just before it 
for, say, ethernet on SCC4 (if that's even possible).

   so, short question -- i know that patch supports relocating SMC1. 
does it also handle *both* SMC1 and SMC2?  or, perhaps, SMC2 all by 
itself?  there's nothing in the writeup i can see that clarified this.

rday
