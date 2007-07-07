Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id A280DDE0F0
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 04:00:29 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Handle reg-shift property for of_serial ports
Date: Sat, 7 Jul 2007 19:52:43 +0200
References: <1183784308.3066.16.camel@shinybook.infradead.org>
	<1183827083.3066.64.camel@shinybook.infradead.org>
	<468FC849.20801@ru.mvista.com>
In-Reply-To: <468FC849.20801@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707071952.44524.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 07 July 2007, Sergei Shtylyov wrote:
> > the reg-shift property. I'll send a patch shortly, and I'll reorder the
> > match table -- if something claims compatibility with both 8250 and
> > 16550, shouldn't we drive it as the latter?
>=20
> =A0 =A0 Certainly. BTW, was there really "ns8250" -- 8250 is Intel's chip?
>=20

No, you're right. http://playground.sun.com/1275/proposals/Closed/Accepted/=
384-it.txt
actually mentions that the the name should be "i8250". It also mentions
that the compatible property should contain "pnpPNP,501" for ns16450 and=20
higher, and "pnpPNP,500" for all serial ports starting from i8250.

	Arnd <><
