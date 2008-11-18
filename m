Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 31EFDDDE08
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 02:06:35 +1100 (EST)
Message-ID: <4922D9E9.5020204@freescale.com>
Date: Tue, 18 Nov 2008 09:06:17 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
Subject: Re: powerpc: udbg based backend for hvc_console
References: <20081024035434.GF4267@yookeroo.seuss>
	<ed82fe3e0811171204y4e8de21dy18f5b332b7f05f1f@mail.gmail.com>
	<20081118004005.GC26336@yookeroo.seuss>
	<ed82fe3e0811172042r1d4887f8n76682e0b21555372@mail.gmail.com>
	<20081118051408.GM26336@yookeroo.seuss>
In-Reply-To: <20081118051408.GM26336@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

> Given the variety of strange I/O configurations in prototype and
> embedded platforms, I can't imagine this was a unique situation.  So
> I've pushed my patch out, so anyone else in a similar situation can
> immediately turn their little udbg methods for whatever strange I/O
> they have into a fully-functional console.  Maybe it's not something
> you'd want to go to release with, but it certainly simplifies life
> during bringup.

Ok, I understand now.  However, I would like to see two changes:

1) Re-arrange the Makefile as I pointed out in another post.

2) Update the Kconfig help file to be very clear that this feature is only
meaningful if the platform has a udbg back-end but no other console or TTY driver.

-- 
Timur Tabi
Linux kernel developer at Freescale
