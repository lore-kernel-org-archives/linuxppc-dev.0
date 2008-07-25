Return-Path: <mbrown@fensystems.co.uk>
Received: from sprocket.fensystems.co.uk (sprocket.fensystems.co.uk
	[212.13.204.53]) by ozlabs.org (Postfix) with ESMTP id 70A5EDE0A5
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 18:10:05 +1000 (EST)
Date: Fri, 25 Jul 2008 08:35:55 +0100 (BST)
From: Michael Brown <mbrown@fensystems.co.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: sfx.c driver build failure
In-Reply-To: <1216966559.11188.85.camel@pasglop>
Message-ID: <Pine.LNX.4.62.0807250831440.8217@dolphin.home>
References: <1216966559.11188.85.camel@pasglop>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="656896-1967781521-1216971355=:8217"
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--656896-1967781521-1216971355=:8217
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 25 Jul 2008, Benjamin Herrenschmidt wrote:
> The sfx driver (which happens to be part of some of our test configs)=20
> fails to build in current Linus tree on powerpc with this error:
>=20
> /home/benh/kernels/linux-powerpc/drivers/net/sfc/efx.c: In function =FF=
=FFefx_probe_interrupts=FF=FF:
> /home/benh/kernels/linux-powerpc/drivers/net/sfc/efx.c:845: error: lvalue=
 required as unary =FF=FF&=FF=FF oper
> and

I'm not the maintainer of that code; I wrote the original version, but=20
it's now maintained by Solarflare.

I don't see anything on that line that ought to be architecture-specific. =
=20
Could you send me the preprocessed efx.c from your powerpc build?

Michael
--656896-1967781521-1216971355=:8217--
