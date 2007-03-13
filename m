Return-Path: <tjuerges@nrao.edu>
Received: from revere.aoc.nrao.edu (revere.aoc.nrao.edu [146.88.1.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 23F23DDE1B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 10:18:32 +1100 (EST)
Message-ID: <45F6E0C7.30403@nrao.edu>
Date: Tue, 13 Mar 2007 11:35:03 -0600
From: Thomas Juerges <tjuerges@nrao.edu>
MIME-Version: 1.0
To: patel nirav <indianirav@yahoo.com>
Subject: Re: gcc -static
References: <15137.37968.qm@web43146.mail.sp1.yahoo.com>
In-Reply-To: <15137.37968.qm@web43146.mail.sp1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-15
Cc: rtai@rtai.org, linux ppc <linuxppc-embedded@ozlabs.org>
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

On 03/13/2007 11:23 AM, patel nirav wrote:
> Hello all, Can any body tell me what is the use of " - static" option
> for gcc compilation ?

man gcc:

- -static
        On systems that support dynamic linking, this prevents linking
        with the shared libraries.  On other systems, this option has no
        effect.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFF9uDGMiyRSD9s+zURAlvnAJ41AjtlgyJFabQ98Nm0Ry1alNy1LgCfU9LY
5Yjt3BobB15FxEn5hXs+MAs=
=KS0W
-----END PGP SIGNATURE-----
