Return-Path: <olh@suse.de>
Received: from Cantor.suse.de (mail.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2494067A2C
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Feb 2005 23:57:33 +1100 (EST)
Date: Thu, 3 Feb 2005 13:57:25 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050203125725.GA20087@suse.de>
References: <1106011958.4533.25.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1106011958.4533.25.camel@gaston>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] ppc32: pmac sleep support update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Tue, Jan 18, Benjamin Herrenschmidt wrote:

> Hi !
> 
> This patch updates the PowerMac sleep support. The ability to sleep is now broken
> into 2 different flags, one, "may sleep" is set for all motherboards that we know
> how to put to sleep and wakeup. It gets turned into "can sleep" upon a call from
> the video driver indicating the ability to wakeup the video card. This doesn't
> deal with head-less machines, but this can be improved later. It also adds better
> cache flush code, which improves stability with cpufreq as well as sleep.
> 
> This patch actually breaks sleep support until the video drivers for the affected
> machines have been updated. This will come as separate patches.

Is that supposed to work? 2.6.11-rc2-bk10 sleeps ok on a pismo, but -rc3
just does nothing when closing the lid.
