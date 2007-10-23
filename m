Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D52FFDDF60
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Oct 2007 04:30:49 +1000 (EST)
Message-ID: <471E3DD8.4060508@freescale.com>
Date: Tue, 23 Oct 2007 13:30:48 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: FDT bindings for I2C devices
References: <4718BB40.2050901@grandegger.com>
	<fa686aa40710190738q1211a266lced10ac8767e5071@mail.gmail.com>
In-Reply-To: <fa686aa40710190738q1211a266lced10ac8767e5071@mail.gmail.com>
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

Grant Likely wrote:
> Scott Wood made an attempt at defining a device binding for I2C
> devices, but it has not been merged into booting-without-of.txt yet.
> I've copied what he wrote below.  I would add to his definition the
> following:
> - If compatible is missing, driver should *not* fall back to the device name.
> - 'compatible' list should include the exact device in the form "<mfg>,<part>"

Those are good recommendations for any node, but I don't see why i2c in 
particular should mandate it.

-Scott
