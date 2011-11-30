Return-Path: <tony@bakeyournoodle.com>
Date: Thu, 1 Dec 2011 10:25:15 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH 4/6] powerpc/boot: Add extended precision shifts to the
 boot wrapper.
Message-ID: <20111130232515.GB15560@thor.bakeyournoodle.com>
References: <1322630640-13708-1-git-send-email-tony@bakeyournoodle.com>
 <1322630640-13708-5-git-send-email-tony@bakeyournoodle.com>
 <1322632107.21641.43.camel@pasglop>
 <CA+5PVA6kBquh2=sPy25PKGSMBWvoZFFvZjrL4bgdmddFgjyaQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
In-Reply-To: <CA+5PVA6kBquh2=sPy25PKGSMBWvoZFFvZjrL4bgdmddFgjyaQA@mail.gmail.com>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 30, 2011 at 06:45:37AM -0500, Josh Boyer wrote:

> However, adding this code and wonderful and all but why do we need to
> add it?  Changelog should say why.

Okay changelog updated to:

    powerpc/boot: Add extended precision shifts to the boot wrapper.
   =20
    The upcoming currituck patches will need to do 64-bit shifts which will
    fail with undefined symbol without this patch.
   =20
    I looked at linking against libgcc but we can't guarantee that libgcc
    was compiled with soft-float.  Also Using ../lib/div64.S or
    ../kernel/misc_32.S, this will break the build as the .o's need to be
    built with different flags for the bootwrapper vs the kernel.  So for
    now the easiest option is to just copy code from
    arch/powerpc/kernel/misc_32.S  I don't think this code changes too ofte=
n ;P

Yours Tony

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJO1rtbAAoJEEsCiJRY75GK4DYP/29a7mE2kntcFmzN5dRjhQWq
kd1DoRc7c6UGHVEXuVWXArp/Dc4IaScjuIWEGRuPTSBhQSUIYDcHUcDj0yUcLt5H
kny0W+R+n//+JktKaKdhiGYPfjbZCHp3F2d/WglEApa+u6vta0zxXxfakA80iBM2
W6f8TT+V5IibpWcuuUXCHc2527O7GJ+otD+nFYMB424sMrjt0sf7Ac+KaMpQnOI0
zeDfRk2yGqQisoC8oultdgYZNlZmc1jczi3wm2thZn4A14/ng3rA1QnnUIHbruNQ
XxQzGfHMf/e7yamYvognFluzOeO29a9jsAvtExYzO/pijvOJQCRRZRPYxyZgZ/n6
oSB6Ic9tnvWgUx8kHBl8sIr+6hICSne9eG5EvdUdNHgf3eaN9FERpAdg80Q6254b
2Un9o/kWnWKykrHoVaeKXFGqr3nWwIgRKX8FxDIjRhqi79l18wKFQD9qNf1qCt1A
Yg6tzLjm1BQxJFWQYvxvPxWEy6NZXWAdmDO1vzsdiHThqf+4oi+glRiZIvy7Lh4p
No7ygulBRo5PmLvCB4v3DngIOYJ0343WfdeAUuvM0ltolH0P72kUM8peQaSzFTxx
uH4uj7hZjRmSjgVpRtl55naSOhzEMOD44IaF+I4uaasQlrnVzgHPbDzUQmwObgeM
VRz2ibLRJ/iYivVVYpio
=cAxy
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
