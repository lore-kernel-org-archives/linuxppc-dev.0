Date: Wed, 11 Oct 2000 14:52:49 -0400
From: Josh Huber <huber@mclx.com>
To: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
Message-ID: <20001011145249.B1437@missioncriticallinux.com>
References: <20001011141722.A1437@missioncriticallinux.com> <39E4B4D0.FA62D929@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
In-Reply-To: <39E4B4D0.FA62D929@student.ethz.ch>; from daenzerm@student.ethz.ch on Wed, Oct 11, 2000 at 08:43:28PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2000 at 08:43:28PM +0200, Michel D?nzer wrote:
> I don't think that's the cause, it fails much later.

That is true, but I thought that if perhaps int10 wasn't able to init
the card fully, that it might cause problems later.  Let's assume
that's not a problem for the moment though :)

> Have you built X yourself? If yes, you need patches from Ani Joshi. The m=
emory
> and clock values it probes are obviously bogus.

> Wait a minute, I see you are using debs, which should contain Ani's stuff.
> Does aty128fb work on the second card? If yes, try Option "UseFBDev".

Yeah, I'm using the debs, but it looks like the latest xserver-xfree86
ppc packages are still at phase2v5, while the other packages are up to
phase2v15.  Perhaps the code is just a little too old?

BTW, no...I don't have aty128fb working on the secondary head -- is
there some option to tell the driver to scan for all cards?  does it
do this by default?

The secondary card is a PC card, so it's not initialized by OF, but I
think the r128 fb driver does a proper initialization of the card, so
that shouldn't be the problem.

btw, I'm using the debian kernel that shipped with potato -- perhaps I
should try a newer one?  ben's or a 2.4 kernel perhaps?

Thanks,
--=20
Josh
| huber@mclx.com |
1024D/6B21489A 61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature
Content-Disposition: inline


--nmemrqcdn5VTmUEE--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
