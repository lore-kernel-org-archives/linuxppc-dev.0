Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4F3CCDDFAD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 01:57:21 +1100 (EST)
Message-ID: <47BAEE3F.2070209@freescale.com>
Date: Tue, 19 Feb 2008 08:57:03 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: maxime louvel <m.louvel@gmail.com>
Subject: Re: 2.6.24 for mpc8458amc
References: <dda529d0802190359r526dc959y8117185e1834e9f4@mail.gmail.com>	
	<47BAE6B3.7090000@freescale.com>
	<dda529d0802190642n56ef7fbcx988ce8825bd315da@mail.gmail.com>
In-Reply-To: <dda529d0802190642n56ef7fbcx988ce8825bd315da@mail.gmail.com>
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
> Thanks for your answer,
> 
> I am going to check this ppc / powerpc things.
> I should use the architecture powerpc, don't I?

ARCH == ppc is scheduled for _removal_ from the
entire Kernel source base is just about 4 months.
Feel free to move the deck chairs around. :-)

> I'm not really sure I have understand what do you want to do with a 
> BDI-2000.

Perhaps, for starters, you read "Building Embedded Linux Systems"
as found here:
    http://www.oreilly.com/catalog/belinuxsys/

> I access the cards through a serial line directly.

Of course.  But when you get no information there,
you might try a different interface.

jdl
