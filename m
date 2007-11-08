Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 46AFADDE21
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Nov 2007 09:30:42 +1100 (EST)
Message-ID: <47338E0C.2080805@freescale.com>
Date: Thu, 08 Nov 2007 16:30:36 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: use of fsl, in lite5200b.dts in git current
References: <9e4733910711071355l75da5444kb7082692f1bdc0@mail.gmail.com>	
	<4732396D.4040904@genesi-usa.com>	
	<9e4733910711071418u5914f188nffc7ab50e62cc88e@mail.gmail.com>	
	<9e4733910711081240l458a5e7h4898fb12e511f29a@mail.gmail.com>	
	<473375E6.5080503@freescale.com>	
	<9e4733910711081251w392b4a84m8e81d902305bf395@mail.gmail.com>	
	<473377F8.2050802@freescale.com>	
	<9e4733910711081353h43ec8978u2db4618090688010@mail.gmail.com>	
	<473387AF.6030105@freescale.com>
	<9e4733910711081417h7a571398md59a8987f15423a6@mail.gmail.com>
In-Reply-To: <9e4733910711081417h7a571398md59a8987f15423a6@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Jon Smirl wrote:
> On 11/8/07, Scott Wood <scottwood@freescale.com> wrote:
>> Several hundred?  I don't think there are several hundred unique
>> property names or compatible entries in arch/powerpc/boot/dts *total*,
> 
> There are 601 'compatible' attributes in the directory.

I said "unique".  And there do appear to be a couple hundred of those, 
though if I omit those containing vendor prefixes, it drops to under a 
hundred.  A big chunk of *those* are 5200-related. :-)

-Scott
