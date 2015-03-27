Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 34C6B1A04D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 17:07:22 +1100 (AEDT)
Date: Fri, 27 Mar 2015 17:02:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 1/3] powerpc/eeh: Move PE state constants around
Message-ID: <20150327060257.GH2900@voom.fritz.box>
References: <1427348529-7060-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1427348529-7060-2-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jRdC2OsRnuV8iIl8"
In-Reply-To: <1427348529-7060-2-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, alex.williamson@redhat.com, agraf@suse.de,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--jRdC2OsRnuV8iIl8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2015 at 04:42:07PM +1100, Gavin Shan wrote:
> There are two equivalent sets of PE state constants, defined in
> arch/powerpc/include/asm/eeh.h and include/uapi/linux/vfio.h.
> Though the names are different, their corresponding values are
> exactly same. The former is used by EEH core and the latter is
> used by userspace.
>=20
> The patch moves those constants from arch/powerpc/include/asm/eeh.h
> to arch/powerpc/include/uapi/asm/eeh.h, which are expected to be
> used by userspace from now on. We can't delete those constants in
> vfio.h as it's uncertain that those constants have been or will be
> used by userspace.
>=20
> Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jRdC2OsRnuV8iIl8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVFPKRAAoJEGw4ysog2bOS1XsP/2MpUWbPdGAJE+4syrPdAc1J
lkIi9y+Y2POnC/Q+7ezx32z9NOBe49xygOgAlrXFT8cR76Nn9iq2IzEDW2zAV2lH
IIcoYtGUeFehKCRTYenfs7rAzhg/pxVoMgP0dvsrlr8AMyENghNinoz895PwbmQl
0KBE+cquDfXQhAjIReBAqTpI3pe5tqMIskvWMZgk27KGpJw+a+3mRnpWgHWwZhdP
qcpxzZMDBDXLL99tFEFDYSYMfXWmkULUhzAJSB8LTSKg9gDdpW/vC9cniOyEGSdh
y2/qgiNu1vQPK8E2YmVLSUaWp7i6S0aIF4ZMNn/puF151VAbO+nLKp7qwx2f1YMW
WuX3M+FYEu0s1ThyMdpiMR7uINoH2Xk3sRKuccz65mWS/ILppMPUrMKZTStNpB8j
B49P3em/VynVS2qlPuif9RSoHVzRcP6KcR3RcK3BOyBndeaJaUbhKAPIa4msvVRz
EmPR2I190/oetFxdqYX2k5eTzdBk+TKVKOxWt2+RUNnHf0SwUFHpZaNiKwBXy7rz
l1hWFms2vOnxolvbK/FZ4LkopqE7bTVIMXnp6Q+knY1htWkf8TiZVi7lRQxh6BVM
jAXdJE7rkJgV2XEGFM4Jy4zDWnmluve4boUbRv6ZmA1S8VUDARa+QK6uBBcXmW+q
1isEAS206ecwmo1mK9Y/
=IIAA
-----END PGP SIGNATURE-----

--jRdC2OsRnuV8iIl8--
