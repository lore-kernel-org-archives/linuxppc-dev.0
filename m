Return-Path: <linux@dominikbrodowski.net>
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCNBw1cHNzDrWQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 02:43:36 +1000 (AEST)
Date: Wed, 19 Jul 2017 18:30:54 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-pm@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V3 8/9] cpufreq: Add CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING
 cpufreq driver flag
Message-ID: <20170719163054.GA32233@light.dominikbrodowski.net>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
 <af15ad23b687e819919eeea687ff44bb37b8e9df.1500373914.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
In-Reply-To: <af15ad23b687e819919eeea687ff44bb37b8e9df.1500373914.git.viresh.kumar@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Wed, Jul 19, 2017 at 03:42:48PM +0530, Viresh Kumar wrote:
> The policy->transition_latency field is used for multiple purposes
> today and its not straight forward at all. This is how it is used:
>=20
> A. Set the correct transition_latency value.
>=20
> B. Set it to CPUFREQ_ETERNAL because:
>    1. We don't want automatic dynamic switching (with
>       ondemand/conservative) to happen at all.
>    2. We don't know the transition latency.
>=20
> This patch handles the B.1. case in a more readable way. A new flag for
> the cpufreq drivers is added to disallow use of cpufreq governors which
> have dynamic_switching flag set.
>=20
> All the current cpufreq drivers which are setting transition_latency
> unconditionally to CPUFREQ_ETERNAL are updated to use it. They don't
> need to set transition_latency anymore.
>=20
> There shouldn't be any functional change after this patch.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Looks good to me, so feel free to add:

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Best,
	Dominik

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmgXaWKgmjrvkPhLCmpdgiUyNow0FAllviTsACgkQmpdgiUyN
ow2ioRAAjTNpeKQzQKAT4Is/AxqrR+Fzgkj5r0+XIhxU/mC25o0ylYZkmELbDRkA
4tRJ1fKdLcCI5a+37TyXuNKU/WKgsoUDiocZIAEKmeFPmml38wycweBCOXgpJ70l
BIElrZEHh+5uWywv9P2ouUVo/Xf+i3y2Lm3eM2Ef+BjpXcUnC5YNAl61U6YnY+re
g8dk+gGR+WxMhEufm1EH4NJ5C7lMSHHNcVHgs6+dmRz6Z5szeJzEx2klyojXob92
W+c4tE1839M24iLXrVWjHaTj1bCpjDaLij4pPOgziFMGwRC6c9RDgNlmICVzwAPU
0Q2ycEuPpxNDep1MsgyFI+S/9jiyjQ3gBwiulcKm1LakCeX+3X9cUrCOmhJVo8Tb
Ikai2sXHfyF22rwMcZF1WF2/9+utE/LkTnf+po2KrMJeAjR+ZlImPeU7KQtmMjbw
ngLOgMkBxZg9RjJ6GqNmAqG2jx8Imi0F3iAGJPn1/nLqmYGN5kLCcTYHgHAdIIQv
HWCbo7+OYlpBBou8BcSdt9+cRVTyVl1Wdq7FAqOnUD9CLmEm8Lp+/ilolKsGN1uD
FNLwhahy/8smCmhFqXV65FrkFbqGoCfo04Twkj3f5ndnlOo4f6u7HQxbOIy92/aG
HoDLJq51NeShdKhTGGesI2ZhVVZhrpzlPpcuyXUOf8xsTT7EYlk=
=aO17
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
