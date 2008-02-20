Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 93778DDDEA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 01:41:54 +1100 (EST)
Message-ID: <47BC3C00.5070701@freescale.com>
Date: Wed, 20 Feb 2008 08:41:04 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: maxime louvel <m.louvel@gmail.com>
Subject: Re: mpc8548amc vs mpc8548cds
References: <dda529d0802200601t2db82c67o808c8407215396c@mail.gmail.com>
In-Reply-To: <dda529d0802200601t2db82c67o808c8407215396c@mail.gmail.com>
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

maxime louvel wrote:
> Hi,
> 
> first of all I am sorry if this is not the good place to ask that but I 
> don't know where else ...
> My question is:
> 
> Does anyone knows the difference between the mpc8548amc and mpc8548cds 
> platforms ?

Sorry, no knowledge of the AMC board here.

> I am working on an amc one but the 2.6.24 kernel is supporting only the 
> cds one.
> Do you know if I can use the dts file form the mpc8548cds for the 
> mpc8548amc ?

They will be similar, but I doubt you can use it directly.

jdl
