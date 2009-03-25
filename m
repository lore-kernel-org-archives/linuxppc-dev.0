Return-Path: <pavel@ucw.cz>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
	[195.113.26.193]) by ozlabs.org (Postfix) with ESMTP id 64C5EDDDA2
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 05:21:04 +1100 (EST)
Date: Wed, 25 Mar 2009 19:23:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: suspend-to-mem on the mpc8349e-mitx-gp?
Message-ID: <20090325182356.GB6708@elf.ucw.cz>
References: <49C3AB35.4080700@freescale.com>
	<3A45394FD742FA419B760BB8D398F9ED2FA48E@zch01exm26.fsl.freescale.net>
	<20090323165402.GC25217@ld0162-tx32.am.freescale.net>
	<2a27d3730903250342qc7c98abt95534372af174703@mail.gmail.com>
	<20090325111113.GG24172@elf.ucw.cz>
	<49CA5C7D.1050904@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49CA5C7D.1050904@freescale.com>
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

On Wed 2009-03-25 11:31:57, Scott Wood wrote:
> Pavel Machek wrote:
>>> Pavel, what's the preferred way for current PM sub-system?
>>
>> If you have single sleep state, use "mem" > /sys/power/state. 
>>
>> If you have two, use mem and standby. Do you have more?
>
> Some of our chips have two, and some have one.  However, the sleep state  
> of the chips that have only one is the same as the "standby" state of  
> the chips that have two, not the "mem" state.  Accepting "mem" and
> only  

Ok, I guess it makes sense to use "standby" for the single sleep
state, then... It is not really a big deal, anyway.

> "mem" for the one-state chip seems like the most confusing of the  
> options discussed.  There would be no consistent way for userspace to  
> request the milder suspend state.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
