Return-Path: <olh@suse.de>
Received: from Cantor.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3592A67A7A
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Feb 2005 08:56:08 +1100 (EST)
Date: Sun, 6 Feb 2005 22:56:00 +0100
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20050206215600.GA2062@suse.de>
References: <20050206125056.GA6394@suse.de>
	<20050206165428.GA7686@smtp.west.cox.net>
	<20050206165629.GA18769@suse.de>
	<20050206172431.GB7686@smtp.west.cox.net>
	<20050206172552.GC19327@suse.de>
	<20050206200431.GC7686@smtp.west.cox.net>
	<20050206200802.GA28652@suse.de>
	<20050206202154.GD7686@smtp.west.cox.net>
	<20050206211506.GA31123@suse.de>
	<20050206214951.GE7686@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20050206214951.GE7686@smtp.west.cox.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] remove .tmp_gas_check
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sun, Feb 06, Tom Rini wrote:

> On Sun, Feb 06, 2005 at 10:15:06PM +0100, Olaf Hering wrote:
> 
> >  On Sun, Feb 06, Tom Rini wrote:
> > 
> > > I agree you shouldn't have to see it.  I'm saying the problem is the
> > > variable shouldn't be evaluated.
> > 
> > This patch seems to work for me.
> 
> What I don't like is that checkbin shouldn't be evaluated for 'tags' or
> other non-compile targets, so you don't need those explicit rm's.  Also,
> you forgot the signed-off-by line :)

Why should make tags or oldconfig ever care about the installed toolchain?
How should the tmpfile disappear if one calls make checkbin with success?
Maybe I misunderstood you.
