Return-Path: <jonathan@jonmasters.org>
Received: from smtp.mailbox.co.uk (smtp.mailbox.net.uk [195.82.125.32])
	by ozlabs.org (Postfix) with ESMTP id E1A8E67A6F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 23:12:27 +1000 (EST)
Message-ID: <424BEECD.8020303@jonmasters.org>
Date: Thu, 31 Mar 2005 13:36:29 +0100
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: jakob.viketoft@bitsim.se
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: tnt@246tNt.com, akonovalov@ru.mvista.com, linuxppc-embedded@ozlabs.org
Subject: Platform bus/ppc sys model - [Fwd: bi_recs and u-boot ppcboot.h]
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

I hope Wolfgang doesn't mind me forwarding this :-) This is what I have
some limited time for at the moment - but work takes priority!

Cheers,

Jon.

- -------- Original Message --------
Subject: bi_recs and u-boot ppcboot.h
Date: Fri, 11 Mar 2005 03:00:18 +0000
From: Jon Masters <jonathan@jonmasters.org>
Organization: World Organi[sz]ation Of Broken Dreams
To: Wolfgang Denk <wd@denx.de>

Hi Wolfgang,

I'm looking at this bi_recs replacement again. Do you have any
particular objection to me extending bd_info (at the end, only if
CONFIG_FAKEOFTREE is selected) to add a pointer to a BLOB of fake OF
device tree?

Assuming not, I'm going to try to figure out how to do this in u-boot.
Do you have a ppc405 board online at the moment with a BDI2000 OOI? I
can't see one on pollux or xpert at the moment - if you've got one spare
that can be made available at some point, please let me know.

( basically, I've got ppcboot on an old CPCI405 here but it's not
trivial to fix if I break it and I don't know much about whether u-boot
supports chaining in to a new u-boot loaded from within itself...but it
probably does, I guess. Bah, it's late, I'm rambling...).

Cheers,

Jon.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCS+7NeTyyexZHHxERAsVkAJ9WK/eHANzVdMTiPVRneHVuitt5FgCeOJCE
Oxf9aVCY4OG5+2kgmJfGgAw=
=BF/h
-----END PGP SIGNATURE-----
