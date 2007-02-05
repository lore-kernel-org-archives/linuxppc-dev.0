Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E1DC6DDDEE
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 19:59:10 +1100 (EST)
Subject: Re: [PATCH] powermac: clean up PIC initialisation code
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1170660074.3554.2.camel@johannes.berg>
References: <1170375448.4036.33.camel@johannes.berg>
	<1170639708.2620.77.camel@localhost.localdomain>
	<1170660074.3554.2.camel@johannes.berg>
Content-Type: text/plain
Date: Mon, 05 Feb 2007 09:58:51 +0100
Message-Id: <1170665931.4059.0.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mo, 2007-02-05 at 08:21 +0100, Johannes Berg wrote:
> On Mon, 2007-02-05 at 12:41 +1100, Benjamin Herrenschmidt wrote:
> 
> > Not fan of having an ifdef here... I'd rather have a pmac_pic_init()
> > that does the right thing, maybe in setup.c
> 
> Ok. From what I can tell it isn't necessary to call of_irq_map_init() on
> newer machines that have an IBM mpic2. So how about this?

Ignore for now, seems I broke something and I can't find what or why
right now.

johannes
