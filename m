Return-Path: <evil@g-house.de>
Received: from mail.g-house.de (ns1.g-housing.de [62.75.136.201])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9387667A75
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Feb 2005 03:58:59 +1100 (EST)
Message-ID: <421B5D73.9020505@g-house.de>
Date: Tue, 22 Feb 2005 17:27:31 +0100
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041206185416.GE7153@smtp.west.cox.net>	<Pine.SOC.4.61.0502221031230.6097@math.ut.ee>	<421B1F12.7050601@gmx.de>
	<5982.195.212.29.67.1109074991.squirrel@195.212.29.67>
In-Reply-To: <5982.195.212.29.67.1109074991.squirrel@195.212.29.67>
Content-Type: text/plain; charset=UTF-8
Cc: Tom Rini <trini@kernel.crashing.org>, Meelis Roos <mroos@linux.ee>,
	linuxppc-dev@ozlabs.org, Sven Hartge <hartge@ds9.gnuu.de>
Subject: Re: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII Utah)
 PCI IRQ map
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Leigh Brown wrote:
>>>It detects the HBA, tries device discovery, gets a timeout, ABORT,
>>>timeout, TARGET RESET, timeout, BUS RESET, timeout, HOST RESET and
>>>there it hangs.

it does not really hang, it just tries to initialize every target of the
HBA (here: from sym0:0:0: to sym0:15:0, see [1] for more info) and it is
so busy with it that the bootprocess seems to hang. after failing with the
last target, booting continues just fine. (i have no disks attached,
booting via nfsroot)

> Ah, this could well be my fault.  Those patches were to improve support
> of IBM RS/6000 PReP boxes.  Do those machines have residual data?  If
> so, could anyone who has one send me the contents of /proc/residual?
> 
> Also, a full boot log when working and failing would be cool.

[1] it's all here: http://nerdbynature.de/bits/hal/2.6.11-rc3/

(yes, they are from different dates, but the setup is the same. the
kernelversion from messages is 2.6.11-rc2, the rest is all 2.6.11-rc3,
from vanilla (-BK) sources)

thanks,
Christian.
- --
BOFH excuse #67:

descramble code needed from software company
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCG11y+A7rjkF8z0wRAvMoAKCWliE97XWNmFv+xf7d3yU5vN3tDQCffMCj
Y8hf0xXrOsCA6WkZUPKkUa0=
=ECSk
-----END PGP SIGNATURE-----
