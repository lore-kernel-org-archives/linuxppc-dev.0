Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de",
	Issuer "StartCom Class 1 Primary Intermediate Server CA" (not
	verified)) by ozlabs.org (Postfix) with ESMTPS id 6F99EDDDEE
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Sep 2008 20:28:39 +1000 (EST)
Message-ID: <48D0DC23.9070902@scram.de>
Date: Wed, 17 Sep 2008 12:29:55 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull from 'for-2.6.27'
References: <Pine.LNX.4.64.0809121546530.6192@blarg.am.freescale.net>	<18BF734B-F71B-4FDD-B3C9-62AA5EB54283@kernel.crashing.org>
	<18639.61790.750450.103022@cargo.ozlabs.ibm.com>
In-Reply-To: <18639.61790.750450.103022@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Paul,

> This looks like a biggish change for after -rc6, and the commit
> message doesn't tell me what dire things will happen if the patch
> doesn't go in, or what systems see this breakage, or whether this is a
> regression since 2.6.26 (I assume it isn't).  It doesn't even tell me
> why not being thread-safe is a problem on a UP machine.

This isn't a regression since the stuff is new in 2.6.27. IMHO this can
wait until 2.6.28.

Thanks,
Jochen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQEVAwUBSNDcHcP9a9GOLSE6AQLqmgf+JwnbVciHzA3idXiTabS2x/k7vkBj+rUp
SIw/OHk+G3jjr/wsZaJoZbtPsChoQ5vAqKJYXFKDSadWzo90zfRgKG29PIcjm3ME
gCX3U/u31T6TdtUVSlhIxDeQuOHCpSSbDuW+++rAomAQkLmderyk997KBVUIALtY
ExsxL5YUBj0NsmQoi0wtguTR1O38/uyiB3t+74hz0E5VoDxzNQFtDCHb/MFJdt6N
OtavyY+ceCYNRmul4R1rmnRazu8Lf05p8inWsf87c7Y6dBPODlxqCIv/qOVa6AdY
8wUCzinTdCA3s1mnWjpfyHvFhFZ+QFolqZdYkYtikCEM+GOsVbKHuA==
=taK6
-----END PGP SIGNATURE-----
