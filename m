Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id D83D92C0164
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 11:52:45 +1000 (EST)
Date: Tue, 23 Apr 2013 11:52:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 5/12] Update firmware_has_feature() to check
 architecture bits
Message-Id: <20130423115244.ce0634dafb66601b407b3d9e@canb.auug.org.au>
In-Reply-To: <517583B7.1070300@linux.vnet.ibm.com>
References: <51757951.2080007@linux.vnet.ibm.com>
 <517583B7.1070300@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__23_Apr_2013_11_52_44_+1000_bfbYjok/25fsTL3r"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__23_Apr_2013_11_52_44_+1000_bfbYjok/25fsTL3r
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

On Mon, 22 Apr 2013 13:38:47 -0500 Nathan Fontenot <nfont@linux.vnet.ibm.co=
m> wrote:
>
> +/* Option vector 5: PAPR/OF options supported
> + * Thses bits are also used for the platform_has_feature() call so

You talk about platform_has_feature(), but that does not exist (I assume
it existed in a previous version of the patch set).

> +bool platform_has_feature(unsigned int);

Ditto.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__23_Apr_2013_11_52_44_+1000_bfbYjok/25fsTL3r
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRdelsAAoJEECxmPOUX5FE8goP/jbebnt4rpkXBnrXNzm/d5mW
xEw4mb55fxtTgNRZkMpojQOn0E3CQDclxP6ZhPO2Q5ju1yH/QIU4aXIQu7xc/RrW
m/G0zGFufVDwyBK/YW2Ou3n39RYOBgBTMatsgnFnF1oMNccWsL29UGWsDGD4UYay
Bor8JY52E8NpC0t4C49gzlEx1tVa6kkCpcHolq3xJmBegR5jlxvAOvpIO3oUspcN
ECpWbEUy4iKX8mHZI12v5WNotGXhlRVAMhFi+Ds/YQifhLXFpsJkv5qLDEcxPBBN
UQM9/e/TF19JDZ6UKfX47p3dEsMPpRoYQADCZBnei74RJmcR30EhcD0mVSNaPAWA
mYHuvUzQSq+V7x/44IN3PcTzOvIpS3SB2lWYQjzq4Us0l249MD6k7LEN/ztdRw3d
SjSNoZTwSkxvotDaSlO13OTYZNxbChDJJkI68kW3KX8QuYEj9baXrVs+0yg7K3Wm
L78r0zEm5OJaDJf65wcxOAc2c5hbzhs/zxPHuXDusRMNJSkwW/gwKdGFvphskgKb
WjcWjRdY9Kt5qtIheSfw0OHKp8SiYV4mCJnqJ4Q2cP0ZfdsFXnWPl9AM+8QVHEAQ
tH9GmLLX9RS6uh1eCyts6VLC6VTzA8pUL+0NNLHZRjchUV9yhdMgsk75WRwWeWLe
DkFrAT7dpKgS6FlxUQT5
=rMPT
-----END PGP SIGNATURE-----

--Signature=_Tue__23_Apr_2013_11_52_44_+1000_bfbYjok/25fsTL3r--
