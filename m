Return-Path: <michel@daenzer.net>
Received: from darkcity.gna.ch (darkcity.gna.ch [195.226.6.9])
	by ozlabs.org (Postfix) with ESMTP id E801B679F6
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2006 04:35:50 +1100 (EST)
Subject: Re: 8272ads:PCI prefetchable mem access problem
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Anil Dhonde <adhonde@yahoo.com>
In-Reply-To: <20060215145954.43697.qmail@web30711.mail.mud.yahoo.com>
References: <20060215145954.43697.qmail@web30711.mail.mud.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Feb 2006 18:04:19 +0100
Message-Id: <1140023059.27426.16.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-02-15 at 06:59 -0800, Anil Dhonde wrote:
>=20
> We have plugged an ATI Radeon video card into a PCI
> slot on our powerpc 8272ads evaluation board. The
> linux kernel 2.6.15 comes up, detects the card on the
> bus, rolls in the ATI Radeon framebuffer driver as it
> should. All register/PCI config space access is fine.

So does radeonfb work, or is that part of the problem?

Note that radeonfb doesn't do the low-level card initialization normally
done by the on-card ROM, (how?) does your evaluation board do that?


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer
