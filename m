Return-Path: <tnt@246tNt.com>
Received: from ns30619.ovh.net (ns30619.ovh.net [213.186.47.155])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1019667A6D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Jun 2006 05:03:50 +1000 (EST)
Message-ID: <20060620210335.q9mgydr5ppkogsoo@webmail.bluenox.com>
Date: Tue, 20 Jun 2006 21:03:35 +0200
From: Sylvain Munaut <tnt@246tNt.com>
To: linuxppc-embedded@ozlabs.org
Subject: RE: Using bestcomm in an external module (MPC5200B to be exact)
References: <4496b9a7.1d040e45.6737.ffff8473@mx.gmail.com>
In-Reply-To: <4496b9a7.1d040e45.6737.ffff8473@mx.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Quoting Trueskew <trueskew@gmail.com>:

> Hi Andrey,
>
> Thanks for the reply.  I did notice that a few weeks ago and was waiting f=
or
> the patch state to be changed from "New" to "Accepted".  Can you give me
> more details on how you found out bestcomm won't be included in 2.6?  The
> latest downloadable LTIB from Freescale for the Lite5200b includes bestcom=
m
> in several places, and the mpc52xx fec driver uses it, along with the ATA
> driver that Sylvain provided a patch for.
>
> As for http://www.246tNt.com/mpc52xx/, it's been coming up "page not found=
"
> for me for those same few weeks when I've tried it off an on, and
> www.246tNt.com just has a Welcome line in it.

Yes sorry about that ...
server crash ... hard ... we kinda lost a lot. Hopefully =20
gitbits.246tNt.com which host the bestcomm stuff is on another server.

I also have a newer / cleaner version of the patch. I've sent it to some
dev (Dale, Andrey & John) for comments (any news on that guys ? or are you
just fine with it ?)

But anyway, it's mainly internal cleanup and adapting drivers
from the public version on my git tree to this newest/cleaner
version is a 15 min work ;)


Sylvain



----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
