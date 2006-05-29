Return-Path: <schmitz@opal.biophys.uni-duesseldorf.de>
Received: from opal.biophys.uni-duesseldorf.de
	(opal.biophys.uni-duesseldorf.de [134.99.176.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.biophys.uni-duesseldorf.de",
	Issuer "mail.biophys.uni-duesseldorf.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5DAAB67A44
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 21:56:08 +1000 (EST)
Date: Mon, 29 May 2006 13:49:59 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [snd] looking for layout-ids
In-Reply-To: <1148679703.8089.162.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0605291349070.26236@xplor.biophys.uni-duesseldorf.de>
References: <1148553785.11759.12.camel@johannes.berg>
	<60381eeb0605260902p4420757ai3669aba711122014@mail.gmail.com>
	<1148679703.8089.162.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	debian-powerpc <debian-powerpc@lists.debian.org>,
	Eddy =?UTF-8?Q?Petri=C5=9For?= <eddy.petrisor@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > > If you get no output, you have no layout-id property. If you do get
> >
> > What are the plans for machines without layout-id, like the 5,2 model?
> > Will there be any alsa/aoa support at some point?
>
> There will be, but let's get the ones with layout-id first since
> snd-powermac should work on the older ones.

It sure does (5,5 at least).

	Michael
