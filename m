Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 79BCEB6F7A
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 24 Jul 2011 22:14:01 +1000 (EST)
Subject: Re: Linux 3.0 boot failure on the Powerbook G4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael =?ISO-8859-1?Q?B=FCsch?= <m@bues.ch>
In-Reply-To: <20110724141051.771d6492@maggie>
References: <20110723222034.6757604b@maggie>
	<1311509250.25044.583.camel@pasglop> <20110724141051.771d6492@maggie>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 24 Jul 2011 22:13:34 +1000
Message-ID: <1311509614.25044.585.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2011-07-24 at 14:10 +0200, Michael Büsch wrote:
> On Sun, 24 Jul 2011 22:07:30 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Sat, 2011-07-23 at 22:20 +0200, Michael Büsch wrote:
> > > Linux 3.0 fails to boot _very_ early on my Powerbook G4. See the
> > > yaboot/OF screenshot:
> > > http://bues.ch/misc/linux-3.0-pbook.jpg
> > > 
> > > Linux 2.6.39.2 boots fine.
> > > Does somebody have an idea?
> > 
> > Interesting, that's before it even kills OF. Are you booting a zImage or
> > a vmlinux ?
> 
> I'm booting zImage.pmac.

Ah that might make it easier... I don't remember where it links, can you
show me the program headers out of readelf -a of the zImage ?

> > It might be also useful to compile yaboot with debug output enabled to
> > figure out where the kernel is loaded so we can try calculating where
> > exactly it dies if it's a vmlinux...
> 
> Hm, I guess I could probably try that.

Cheers,
Ben.
