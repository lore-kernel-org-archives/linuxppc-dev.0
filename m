Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id 24A7767B26
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Jun 2005 23:18:40 +1000 (EST)
Message-ID: <42B02AAD.6050805@anagramm.de>
Date: Wed, 15 Jun 2005 15:18:37 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Alex Zeffertt <ajz@cambridgebroadband.com>
References: <20050614104749.387910e0.ajz@cambridgebroadband.com>
In-Reply-To: <20050614104749.387910e0.ajz@cambridgebroadband.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Anyone got drivers/mtd/maps/pm828.c?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Alex!

Hmm, I don't know the PM828 much in detail, but have you
tried the "generic" physmap driver which is in the kernel?
Just give it the base address and the size, and it should
probe the cfi and you are done (well, it was working fine
for me on my PM854).
Of course, you need to make sure, that your hardware / memory
mapping is initialized properly (which happens usually in the
boot loader). If it's not, let me know and I can give you
some code to mess around with the registers in a kernel module.

Best greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19


Alex Zeffertt wrote:
> Hi there,
> 
> I need to get flash partitions working on my PM828 development board. 
> Has anybody already written a pm828.c?  If so I'd appreciate a look at
> it.
> 
> TIA,
> 
> Alex
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
