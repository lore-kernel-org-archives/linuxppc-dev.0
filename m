Return-Path: <olh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DC5B367B7B
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Jul 2006 05:50:12 +1000 (EST)
Date: Sun, 16 Jul 2006 21:50:08 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: crash in aty128_set_lcd_enable on PowerBook
Message-ID: <20060716195008.GA17557@suse.de>
References: <20060716163728.GA16228@suse.de> <20060716165004.GA16369@suse.de>
	<1153077550.5905.33.camel@localhost.localdomain>
	<1153077953.5905.37.camel@localhost.localdomain>
	<20060716192727.GA17387@suse.de>
	<1153079015.5905.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1153079015.5905.39.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sun, Jul 16, Benjamin Herrenschmidt wrote:

> > It crashes later for different reasons. The whole init process works by
> > luck it seems.
> 
> I've been having weird things happening with latest linus trees and
> really no time to debug ... do you have a backtrace for the "other"
> crash ?

It was in aty128_bl_set_power(), cant remember the trace.
