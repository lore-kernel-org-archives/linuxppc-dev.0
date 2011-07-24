Return-Path: <m@bues.ch>
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 60603B6F75
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 24 Jul 2011 20:37:48 +1000 (EST)
Date: Sun, 24 Jul 2011 12:37:39 +0200
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Linux 3.0 boot failure on the Powerbook G4
Message-ID: <20110724123739.2beb8964@maggie>
In-Reply-To: <m2tyacdrx0.fsf@igel.home>
References: <20110723222034.6757604b__32574.6897528463$1311473425$gmane$org@maggie>
	<m2tyacdrx0.fsf@igel.home>
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

On Sun, 24 Jul 2011 10:06:03 +0200
Andreas Schwab <schwab@linux-m68k.org> wrote:

> Michael B=C3=BCsch <m@bues.ch> writes:
>=20
> > Linux 3.0 fails to boot _very_ early on my Powerbook G4. See the
> > yaboot/OF screenshot:
> > http://bues.ch/misc/linux-3.0-pbook.jpg
> >
> > Linux 2.6.39.2 boots fine.
> > Does somebody have an idea?
>=20
> Perhaps your image is getting too large?

I reduced the image size, so that it's way less than the
2.6.39 kernel size (old is 2.6.39. a is 3.0)
-rwxr-xr-x 1 root root 5.6M Jul 24 12:16 /boot/linux.a
-rwxr-xr-x 1 root root 6.3M Jul 23 20:50 /boot/linux.old

But that didn't help. :(

I'm currently trying to bisect it, but that turns out to be hard
due to various compile issues and stuff like that...

--=20
Greetings, Michael.
