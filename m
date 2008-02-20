Return-Path: <kalle.pokki@eke.fi>
Received: from smtp1.aina.net (smtp1.aina.net [81.16.64.154])
	by ozlabs.org (Postfix) with ESMTP id 8015CDDE10
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 04:11:41 +1100 (EST)
Date: Wed, 20 Feb 2008 19:06:29 +0200 (EET)
From: Kalle Pokki <kalle.pokki@eke.fi>
To: Ben Warren <biggerbadderben@gmail.com>
Subject: Re: ELDK on 64-bit host
In-Reply-To: <f8328f7c0802200749h7a761fffha636f292b54182e5@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0802201807340.7503@pc-213-140-179-32.aina.net>
References: <a425f86c0802200703x6cbbd5acwa4b3a8dda455eeea@mail.gmail.com>
	<f8328f7c0802200749h7a761fffha636f292b54182e5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 20 Feb 2008, Ben Warren wrote:

> On Wed, Feb 20, 2008 at 10:03 AM, Kalle Pokki <kalle.pokki@eke.fi> wrote:
> > Hi,
> >
> >  I tried to copy the ELDK 4.0 installation I had to a new Core 2 Quad
> >  machine running 64-bit Ubuntu 7.10, but the new machine refuses to
> >  execute the cross compiler. Has anyone succeeded in running ELDK in
> >  this kind of environment?
> >
> Yes (at least with 64-bit Debian on a single core Xeon), but you need
> a special library on the host.  I think it's call 'ia32-libs'.  It
> should be available via aptitude.

Thanks, that was indeed the correct library to install. Now it works just 
fine.

I'm a bit surprised there wasn't really any useful search results from 
Google with obvious keywords. I was already about to install the 32-bit 
version of Ubuntu to get the compiler working again. But then, perhaps 
installing this library was obvious to everyone else :)
