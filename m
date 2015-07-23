Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B918A1A03F4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 16:50:57 +1000 (AEST)
Received: by pacan13 with SMTP id an13so154032713pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 23:50:55 -0700 (PDT)
Message-ID: <1437634142.13972.12.camel@axtens.net>
Subject: Re: [PATCH v5 7/7] powerpc/powernv: nest pmu cpumask and cpu
 hotplug support
From: Daniel Axtens <dja@axtens.net>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Peter
 Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Preeti U Murthy <preetium@andrew.cmu.edu>, Sukadev Bhattiprolu
 <sukadev@linux.vnet.ibm.com>,  Ingo Molnar <mingo@kernel.org>, Anshuman
 Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 23 Jul 2015 16:49:02 +1000
In-Reply-To: <55B08E28.3090902@linux.vnet.ibm.com>
References: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1437045206-7491-8-git-send-email-maddy@linux.vnet.ibm.com>
 <1437541404.30906.43.camel@axtens.net>
 <55B08E28.3090902@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-w4dUtyaIAhnlROiwOeHw"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-w4dUtyaIAhnlROiwOeHw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2015-07-23 at 12:18 +0530, Madhavan Srinivasan wrote:
>=20
> On Wednesday 22 July 2015 10:33 AM, Daniel Axtens wrote:
> >> +static void nest_change_cpu_context(int old_cpu, int new_cpu)
> >> +{
> >> +	int i;
> >> +
> >> +	for (i =3D 0; per_nest_pmu_arr[i] !=3D NULL; i++)
> >> +		perf_pmu_migrate_context(&per_nest_pmu_arr[i]->pmu,
> >> +						old_cpu, new_cpu);
> > From patch 4, I see per_nest_pmu_arr is defined as:
> >  +static struct nest_pmu *per_nest_pmu_arr[P8_NEST_MAX_PMUS];
> >
> > Therefore, does this loop need to have a check that=20
> > i < P8_NEST_MAX_PMUS?
>=20
> No, that is max possible pmu, but we may have only couple for nest pmus
> registered.
>=20
What if we have P8_NEST_MAX_PMUS registered? Then we'll check beyond the
end of the array...

> Thanks for the review comments
> Maddy
> >
>=20

--=20
Regards,
Daniel

--=-w4dUtyaIAhnlROiwOeHw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVsI5eAAoJEPC3R3P2I92FL0gP/iGznvY0SYCQ0p6Q7KojJ5Fe
11NRN514BzG7t6cTGIYvElUdILR/swTNVdletXgc5idbAy0SOJ7Hk8LquFXZ3Avf
sZm9IZNgRMNpKLSTSC032A1trs+JWyLD7ghfGDKQ0ofX7FVZkBpl0TX0X0lid9RX
AdEWM0lyrocwy56S2opHks1ANt+E+7fQtCNXNH/CIfEVyDTegBwgTFEentn161xU
8MHoBckOHj5tEi65T1Scm2sjx1PL+YSIHYsHp/TT20czVB7QZaOyDMotPX6oIDB6
QszuqzLmG7RlFXCmRrZH8Rq/AoFJ9F9NdW4YKkrlmuaUpgK2Hg3Su18t/2IeYH8n
n7b/g9Jp35Kr9EeMfiBBypZ6qUVu+b6sU2JyyXr5OD8y8pb1oUE4XTxNn9dIgPIT
zoKNQYjDqcSJ+XeQS3hs3568uLUB9HbG4pS1ZFOOIBt7EsJtMcql07R89ymQgqib
pa4nRs5+8DNobo1mzwvUzaDqSy7IIW2HwK68RoTtYi+VPG6ZKjc4G6/kk8jieR7R
Dc7hUfpcAyYx/MBkBPlvziL2XARWGpW+4LERILWWSvMIbylwSoIbJ3mC1ExjkegO
g3IRVkLJvRy7hUfLC46lFh8EOxY0VSIQCJ1di1eSILjcMx+ggc8aEI+OtSUIKDVX
FObbYaWBGtQA/hPxG8A5
=skCT
-----END PGP SIGNATURE-----

--=-w4dUtyaIAhnlROiwOeHw--
