Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8EF031A0631
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2015 10:50:04 +1000 (AEST)
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com
 [IPv6:2607:f8b0:400e:c03::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 13E891402DD
 for <linuxppc-dev@ozlabs.org>; Mon,  3 Aug 2015 10:50:03 +1000 (AEST)
Received: by pacan13 with SMTP id an13so77262549pac.1
 for <linuxppc-dev@ozlabs.org>; Sun, 02 Aug 2015 17:50:02 -0700 (PDT)
Message-ID: <1438562877.31010.16.camel@axtens.net>
Subject: Re: [PATCH] cxl: Fix ambiguous else warnings
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andreas Schwab <schwab@linux-m68k.org>, Thomas Huth <thuth@redhat.com>,
 linuxppc-dev@ozlabs.org, mikey@neuling.org, imunsie@au.ibm.com
Date: Mon, 03 Aug 2015 10:47:57 +1000
In-Reply-To: <1438562604.8863.1.camel@ellerman.id.au>
References: <1438324508-30341-1-git-send-email-dja__13473.5064967119$1438324749$gmane$org@axtens.net>
 <87wpxg3cvv.fsf@igel.home> <1438562207.31010.14.camel@axtens.net>
 <1438562604.8863.1.camel@ellerman.id.au>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-fr8Ky7mLGU06YQlXOyKP"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-fr8Ky7mLGU06YQlXOyKP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> This should be a static inline, not a #define.
>=20
I'm changing them to static inlines at the moment. Would you prefer a v3
of the EEH patches, or a new patch on top?

--=20
Regards,
Daniel

--=-fr8Ky7mLGU06YQlXOyKP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVvro9AAoJEPC3R3P2I92FU5AQANsYg9VTvpr+uIPqdIAx6WmD
ueVZ5vKDMFapsHtd/K3u/gbZJ6pZb2qyUiuCmXrXKt6EPUvGOjkE1VvFcan2bKWr
uRVAORHz+MlHOu9TEcqqMs9L1PHUW3e+6rmOrFICtw8bQBEv0UIRvvGSGAucN2KF
q7hA6nvveYwrdUu5h6Fs27maPCfOeZFdk9/F/81PNUi2mJOUDF33P8y1zgoaEIj5
/sttlfASt0yO32RowW9K+dBdy3AinXE6jHYnVVZZKAqO3Q+zqpptdTFkD21155T2
dg+oIdwGQ9aLJ6sxSfnnEoNBpnAACtQ41gZkBMTw7RBhTgfi8Bl8S+ZGKyT5ejGb
ZRCbohCkVsG6fRw0iejx2P7vvwaKxA8vlGxztjxnJv2eCBe6/yB8AwdT2qYpWdB4
tIsgAf9zNhs3dcwj4ZlGUlVyJRMsaXFOnj+jDD8syV3x6XO/T6H4sSqz0b5OUC3t
9dPuu6WTUBW/+5Tc+6xJtspQxFeQCBs3DhVotrI6UE5stVfZIKNhkKSi92pAF19g
JnIOSaMCHqeB68TFKqWfUlrtPjXSgfSA4MzaqVkzYqzSm5oo9mTE0N6fkiKVvnqr
Ndl+zlehfrQZgVP56eDvNV74ziUGAvphcvVH1SmXZtKOKd0DluMMx1sVqOH2qN6Y
cgMfQ3/3asV4TrgHfIAm
=pKpY
-----END PGP SIGNATURE-----

--=-fr8Ky7mLGU06YQlXOyKP--
