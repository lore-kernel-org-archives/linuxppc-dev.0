Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 067E01A017D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 16:40:26 +1000 (AEST)
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com
 [IPv6:2607:f8b0:400e:c03::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 66EBA140326
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2015 16:40:24 +1000 (AEST)
Received: by pawu10 with SMTP id u10so157431439paw.1
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 23:40:22 -0700 (PDT)
Message-ID: <1439275084.24419.27.camel@axtens.net>
Subject: Re: [PATCH v2 04/10] cxl: Clean up adapter MMIO unmap path.
From: Daniel Axtens <dja@axtens.net>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, imunsie@au.ibm.com
Date: Tue, 11 Aug 2015 16:38:04 +1000
In-Reply-To: <20150811135249.4fdacf75@camb691>
References: <1438061323-20710-1-git-send-email-dja@axtens.net>
 <1438061323-20710-5-git-send-email-dja@axtens.net>
 <20150811135249.4fdacf75@camb691>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-4rF3oPP6Q20Vm96/kiOQ"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-4rF3oPP6Q20Vm96/kiOQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cyril,
> >  - PCI regions are allocated in cxl_map_adapter_regs.
> >    Therefore they should be released in unmap, not elsewhere.
> >=20
>=20
> You've changed the order in which cxl_remove_adapter() does its work, whi=
ch,
> I'm sure you've considered and it's fine, best to check.

Yeah, I have considered this. I've also tested it a lot.

Thanks for the review.

> Acked-by: Cyril Bur <cyrilbur@gmail.com>


--=20
Regards,
Daniel

--=-4rF3oPP6Q20Vm96/kiOQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVyZhMAAoJEPC3R3P2I92FZ3wQAM7r61uSMHM3x2r3NGtdGJyd
vmkilzgRUnkhDfyj6xKyiqB/7yA27D4IVBnHMTLtOh6LVIiX+yUBN8SnL8iiZVgq
kJWoYhgxQiHJQDLaecul91SgGF8cd9Pgw0dlCecTQX92/gGrzWkQZ5/svvlZz6F8
76FW9UE7quJewo6G0l8BhtzW9wpy/lRQ8oHir4IrYrM2yWZ0oFGBRkmyPbuAmk0T
mJwhhC9Ur53vcelTSpC1T1JiQeyDaBVjivpGImWl3Vdg1QvOp88QirfmmeGO0y5b
VB0V3/ZDjMFShmuse8SRxcgYFbu55hS+TpJqlmRkvDiAqPX2JjS14nYZjSW8+s9w
lQcR8tY2NLNrum4KGdkFUisXtSe3p3LTdkFxVojY1a8ZuOxPcbS070eaiIkSZX5R
nCo4wDrDnReTTfGQf/1MBGjxMwFYhv56vbGNTr2bF5cCUPaJ9vLkhTRSutHhShJd
4bOhKoDyRB19afJEwhA7CknXuAP1fXMZrWVAgqjLCaV+L0HTBcWtAhaTZUWufxjJ
SbbuoGvwxq4f2A04Jx2fKx0FkrE3A9DQB5XzVZuNEK8fJ25VsBKw2JH4ML1/1Viv
2CBXoR4nr//8CZzVh4PlV6pJhJcFgG5OA1t/EvDOKSNt8UT3RWiLg3rbwVggBOd3
P+6AzGr7PivbIVa0u3IP
=Gkzf
-----END PGP SIGNATURE-----

--=-4rF3oPP6Q20Vm96/kiOQ--
