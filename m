Return-Path: <tony@bakeyournoodle.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1FAC01A02E8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 09:59:21 +1100 (AEDT)
Date: Mon, 16 Mar 2015 09:59:13 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc: Add a proper syscall for switching endianness
Message-ID: <20150315225912.GA39518@thor.bakeyournoodle.com>
References: <1426221564-15086-1-git-send-email-mpe@ellerman.id.au>
 <1426228726.23806.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
In-Reply-To: <1426228726.23806.3.camel@ellerman.id.au>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
 Jeremy Kerr <jk@ozlabs.org>, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Mar 13, 2015 at 05:38:46PM +1100, Michael Ellerman wrote:

> According to Paul there are no working implementations of LE on 32-bit cpus, so
> the syscall doesn't really make sense there.

Ummm that doesn't sound right.  I don't think there is an LE linux userspace
but I'm pretty sure we had 32-bit working on 44x.  Check where Ian did the
initial LE patchset.

Yours Tony.

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVBg7AAAoJEPvNNsFAAoTBd8kQAPaO0sOCsjn3fAjn6Z1SF1uq
kMFi4nTuvWFXyTuFWScoxaO+hVODJ/c2R30h8ZBwO0m3rVWEaaw7QmA6lRYThf56
uzzAxGQQaEEKkhS+b/TT8m1oHJYB+LQnCKWwlwS7a0APAFOYrYztRM4aRCsK28po
7xzdml2P3YPrnrh8YzPgV1Zon3Vfnlax5mvhz55UzFBuJY12dwADHTO2bx2u3Gjg
APyjLK1vacyZX0zCQsqIQWBk8YTkskP+sKZU5x9Afk15vUfWD5cHa286ugmihlFM
zxdJOenEbSp2yE1gnI+HMbHotlreuJamdqDeoYFxgHyRCnfbXwPNjuibLtQ7lQnF
kb+vMOCvBsZtKYtkntS2V7O9TB3Y8XB9mL62bG2sRW+VBDnQFtienkQzHT7cMzXj
kaHpE6+fKvNgOwstdAFDnSh35mpejwJUlLS4seGOG8CHJ6SPJCcLcegNfqjEnPcT
gzguKmYihxi/WyE64diwgQ1gb2P5MFHNzYiTN5242kyaDUv6D3bxom9iWhf41UjS
T4lmJOCcmirIlKvCBpE+Fu962Yu2ak5MKLbdoe51+Xh8YttgaGKk5Hf90qzsyWXB
kOtB34QEhuX3RfJP7mMuiOz82BzL9loPmt62DbTYX3O9J9JCAfNhJL4VjvfCfm/6
/5ObZi2LhWGXMqZZ1IEj
=ftLB
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
