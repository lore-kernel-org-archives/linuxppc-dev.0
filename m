Return-Path: <evil@g-house.de>
Received: from mail.g-house.de (ns1.g-housing.de [62.75.136.201])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D79D967A76
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Feb 2005 11:24:42 +1100 (EST)
Message-ID: <421E7033.1030600@g-house.de>
Date: Fri, 25 Feb 2005 01:24:19 +0100
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: Sven Luther <sven.luther@wanadoo.fr>
References: <20041206185416.GE7153@smtp.west.cox.net>
	<Pine.SOC.4.61.0502221031230.6097@math.ut.ee>
	<20050224074728.GA31434@pegasos>
	<Pine.SOC.4.61.0502241746450.21289@math.ut.ee>
	<20050224160657.GB11197@pegasos>
In-Reply-To: <20050224160657.GB11197@pegasos>
Content-Type: text/plain; charset=UTF-8
Cc: Tom Rini <trini@kernel.crashing.org>, Meelis Roos <mroos@linux.ee>,
	Sven Hartge <hartge@ds9.gnuu.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
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

Sven Luther wrote:
> 
> Oh, damn, need to fix my daily builder, should be ok for tomorrow. IN the
> meanwhile, you can try : 
> 
>   http://people.debian.org/~luther/d-i/images/2005-02-23/powerpc/netboot/vmlinuz-prep.initrd

oh, what fun - it's booting! de4x5 is loading (although i build my kernels
with a (compiled in) tulip driver). sym53c8xx gets loaded and initializing
the scsi bus is *not* blocking all other activities as usual.

here are the logs:

http://nerdbynature.de/bits/hal/d-i-2005.02.23/  (working 2.6.8 from Sven)
http://nerdbynature.de/bits/hal/2.6.11-rc3/      (scsi errors)

(note: i still have no disks attached)

thank you,
Christian.
- --
BOFH excuse #286:

Telecommunications is downgrading.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCHnAz+A7rjkF8z0wRAsxtAJ9DPKaUg9nCWGZKGxqd6sCOtVqu1QCfRyjp
934bVyFtXvuTFYLCgQcAhrI=
=hSxn
-----END PGP SIGNATURE-----
