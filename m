Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2DC1DDDE98
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Nov 2007 07:47:39 +1100 (EST)
Message-ID: <473375E6.5080503@freescale.com>
Date: Thu, 08 Nov 2007 14:47:34 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: use of fsl, in lite5200b.dts in git current
References: <9e4733910711071355l75da5444kb7082692f1bdc0@mail.gmail.com>	<4732396D.4040904@genesi-usa.com>	<9e4733910711071418u5914f188nffc7ab50e62cc88e@mail.gmail.com>
	<9e4733910711081240l458a5e7h4898fb12e511f29a@mail.gmail.com>
In-Reply-To: <9e4733910711081240l458a5e7h4898fb12e511f29a@mail.gmail.com>
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
> No one has answered this yet. It makes no sense at all to mix use of
> the vendor prefix on some compatible entries and not on others. The
> syntax of compatible entries needs to be consistent.

Right, the vendor prefix should always be used.  Not all of the existing 
trees are perfect, however, so sometimes the code needs to stay 
compatible, especially when the device tree is difficult to change.

-Scott
