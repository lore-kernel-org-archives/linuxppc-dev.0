Return-Path: <m@bues.ch>
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8110B6F75
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 24 Jul 2011 22:11:00 +1000 (EST)
Date: Sun, 24 Jul 2011 14:10:51 +0200
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Linux 3.0 boot failure on the Powerbook G4
Message-ID: <20110724141051.771d6492@maggie>
In-Reply-To: <1311509250.25044.583.camel@pasglop>
References: <20110723222034.6757604b@maggie>
	<1311509250.25044.583.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 24 Jul 2011 22:07:30 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sat, 2011-07-23 at 22:20 +0200, Michael B=C3=BCsch wrote:
> > Linux 3.0 fails to boot _very_ early on my Powerbook G4. See the
> > yaboot/OF screenshot:
> > http://bues.ch/misc/linux-3.0-pbook.jpg
> >=20
> > Linux 2.6.39.2 boots fine.
> > Does somebody have an idea?
>=20
> Interesting, that's before it even kills OF. Are you booting a zImage or
> a vmlinux ?

I'm booting zImage.pmac.

> It might be also useful to compile yaboot with debug output enabled to
> figure out where the kernel is loaded so we can try calculating where
> exactly it dies if it's a vmlinux...

Hm, I guess I could probably try that.

--=20
Greetings, Michael.
