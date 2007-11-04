Return-Path: <riesebie@lxtec.de>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net [83.223.95.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtpout.hostsharing.net",
	Issuer "Hostsharing eG Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 25ED1DDE45
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Nov 2007 21:56:34 +1100 (EST)
Date: Sun, 4 Nov 2007 11:38:09 +0100
From: Elimar Riesebieter <riesebie@lxtec.de>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: 2.6.24-rc1 freezes on powerbook at first boot stage
Message-ID: <20071104103809.GA2788@aragorn.home.lxtec.de>
References: <20071024120739.GA4897@aragorn.home.lxtec.de>
	<20071024124109.GA9442@frodo.home.lxtec.de>
	<20071104032006.GG9695@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20071104032006.GG9695@localdomain>
Cc: linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 03 Nov 2007 the mental interface of
Nathan Lynch told:

> (cc'ing linuxppc-dev, see
> http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg221770.html
> for original post and .config)
[...]
> > console handover: boot [udbg0] -> real [tty0]
>=20
> Does 2.6.23 (or any earlier kernel) work?
The powerbook runs Linux since 2.6.12. The config is generated
always by make oldconfig and checking new options for meaningful
use. If I have time, I test rc versions.

Thanks for cooperation :)

Elimar

--=20
  Experience is something you don't get until=20
  just after you need it!
