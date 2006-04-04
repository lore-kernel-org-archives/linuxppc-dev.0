Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4A58E679F6
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Apr 2006 05:02:31 +1000 (EST)
Date: Tue, 4 Apr 2006 21:02:11 +0200
From: Olaf Hering <olh@suse.de>
To: Doug Maxey <dwm@austin.ibm.com>
Subject: Re: [PATCH] powerpc: iSeries has only 256 IRQs
Message-ID: <20060404190211.GA26830@suse.de>
References: <20060404183442.GA25986@suse.de>
	<200604041855.k34ItP00022551@falcon10.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200604041855.k34ItP00022551@falcon10.austin.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Tue, Apr 04, Doug Maxey wrote:

> What firmware level?

Of the card? No idea. At some point I had to upgrade it to make it
usable with lpfc in SLES9 SP2. But right now I couldnt upgrade it, kind
of chicken/egg problem. Driver has to be loaded to upgrade the firmware.
I will try to put that card into another box to upgrade the firmware.

I think the irq change itself is not the cause for the crash here.
