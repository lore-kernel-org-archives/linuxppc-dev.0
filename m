Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 239A367B88
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jul 2006 07:41:20 +1000 (EST)
Date: Fri, 21 Jul 2006 07:25:55 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: mainly iSeries updates
Message-Id: <20060721072555.21cfb61d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__21_Jul_2006_07_25_55_+1000_xV_t9LBCSf_sSONC"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__21_Jul_2006_07_25_55_+1000_xV_t9LBCSf_sSONC
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Please pull ozlabs.org:~sfr/kernels/sfr.git to get the following:

Michael Ellerman:
      [POWERPC] iseries: Use device tree /system-id in /proc/iSeries/config
      [POWERPC] iseries: Move e2a()/strne2a() into their only caller
      [POWERPC] iseries: Cleanup e2a() and strne2a()
      [POWERPC] iseries: Make ItExtVpdPanel private to iSeries
      [POWERPC] iseries: Make HvLpConfig_get(Primary)LpIndex functions
      [POWERPC] iseries: Move ItLpNaca into platforms/iseries
      [POWERPC] iseries: Fix a compiler warning in platforms/iseries/vpdinf=
o.c
      [POWERPC] iseries: Fix a compiler warning in platforms/iseries/vpdinf=
o.c
      [POWERPC] Fix a compiler warning in mm/tlb_64.c
      [POWERPC] iseries: Move iommu_table_cb into platforms/iseries

Stephen Rothwell:
      [POWERPC] iseries: A new iSeries console
      [POWERPC] Make the hvc_console output buffer size settable
      [POWERPC] iseries: Small viotape cleanup allowed by devfs removal
      [POWERPC] iseries: Remove unnecessary include of iseries/hv_lp_event.h

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__21_Jul_2006_07_25_55_+1000_xV_t9LBCSf_sSONC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEv/TuFdBgD/zoJvwRAopHAKCiJQHfO3ISg1HruQyI+mJftMxpWgCfbGsm
w4GD/jGgKaUu9BZWdQs5zR8=
=J9ON
-----END PGP SIGNATURE-----

--Signature=_Fri__21_Jul_2006_07_25_55_+1000_xV_t9LBCSf_sSONC--
