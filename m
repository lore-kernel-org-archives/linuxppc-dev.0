Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 59B13DDDA5
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 03:32:35 +1100 (EST)
Message-ID: <49CA5C7D.1050904@freescale.com>
Date: Wed, 25 Mar 2009 11:31:57 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend-to-mem on the mpc8349e-mitx-gp?
References: <49C3AB35.4080700@freescale.com>
	<3A45394FD742FA419B760BB8D398F9ED2FA48E@zch01exm26.fsl.freescale.net>
	<20090323165402.GC25217@ld0162-tx32.am.freescale.net>
	<2a27d3730903250342qc7c98abt95534372af174703@mail.gmail.com>
	<20090325111113.GG24172@elf.ucw.cz>
In-Reply-To: <20090325111113.GG24172@elf.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	Soohyung Cho <celius202@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Pavel Machek wrote:
>> Pavel, what's the preferred way for current PM sub-system?
> 
> If you have single sleep state, use "mem" > /sys/power/state. 
> 
> If you have two, use mem and standby. Do you have more?

Some of our chips have two, and some have one.  However, the sleep state 
of the chips that have only one is the same as the "standby" state of 
the chips that have two, not the "mem" state.  Accepting "mem" and only 
"mem" for the one-state chip seems like the most confusing of the 
options discussed.  There would be no consistent way for userspace to 
request the milder suspend state.

-Scott
