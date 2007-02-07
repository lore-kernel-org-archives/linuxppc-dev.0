Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 50F81DDEE0
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 23:21:00 +1100 (EST)
Subject: Re: patches in powerpc.git
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17865.20353.116215.380614@cargo.ozlabs.ibm.com>
References: <17865.20353.116215.380614@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-S5sbRJE5or7rRXxVkExb"
Date: Wed, 07 Feb 2007 13:18:08 +0100
Message-Id: <1170850688.6798.25.camel@johannes.berg>
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


--=-S5sbRJE5or7rRXxVkExb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-02-07 at 15:03 +1100, Paul Mackerras wrote:

> If anyone has patches not listed here that they want in 2.6.21, please
> let me or the relevant sub-arch maintainer know.  I have put in all
> the patches I know about that don't seem to be still under
> discussion.=20

I'd love to have some of the prereq patches for suspend on G5 go in, as
well as the IRQ comment fix I've been carrying around.

The ones that I think are ready to go are:
 * powerpc: fix comment in kernel/irq.c
   obvious comment change

 * powermac: clean up PIC initialisation code
   just some code shuffling, tested on powermac and powerbook

 * windfarm: don't die on suspend thread signal
   obvious fix

 * powermac: generic time suspend/resume code
   really should be named "powerpc: ...", tested on powermac and
   powerbook

johannes

--=-S5sbRJE5or7rRXxVkExb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFycOA/ETPhpq3jKURAsIVAKCrWnkBHVqs1AdZTVouV+BoihE/pACfV7hA
iazn3trg9n2b131PIAhx6fg=
=oPs8
-----END PGP SIGNATURE-----

--=-S5sbRJE5or7rRXxVkExb--
