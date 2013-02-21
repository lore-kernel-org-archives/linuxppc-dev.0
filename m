Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 7BF652C0092
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2013 08:30:29 +1100 (EST)
Date: Fri, 22 Feb 2013 08:30:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: linux-next: manual merge of the signal tree with the powerpc tree
Message-Id: <20130222083023.00d9f891e4a2d9b386078d70@canb.auug.org.au>
In-Reply-To: <27231.1361479429@ale.ozlabs.ibm.com>
References: <20130221155208.bcb1295ab9bdecf394d48bfc@canb.auug.org.au>
 <1361425813.4676.47.camel@pasglop>
 <27231.1361479429@ale.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__22_Feb_2013_08_30_23_+1100_MGAb3sp07xvf_BDy"
Cc: Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Al Viro <viro@ZenIV.linux.org.uk>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__22_Feb_2013_08_30_23_+1100_MGAb3sp07xvf_BDy
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Thu, 21 Feb 2013 14:43:49 -0600 Michael Neuling <mikey@neuling.org> wrot=
e:
>
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>=20
> > On Thu, 2013-02-21 at 15:52 +1100, Stephen Rothwell wrote:
> > >=20
> > > Today's linux-next merge of the signal tree got conflicts in
> > > arch/powerpc/kernel/signal_32.c and arch/powerpc/kernel/signal_64.c
> > > between commit 2b0a576d15e0 ("powerpc: Add new transactional memory s=
tate
> > > to the signal context") from the powerpc tree and commit 7cce246557bf
> > > ("powerpc: switch to generic sigaltstack") from the signal tree.
> > >=20
> > > I fixed it up (I think - see below) and can carry the fix as necessary
> > > (no action is required).
> >=20
> > Mikey, can you check everything's all right ?
> >=20
> > I'm happy to wait for Al stuff to go in first & fixup the conflict
> > before I send the pull request to Linus. I'm off travelling around but I
> > should be able to get stuff out this week-end.
>=20
> The merge looks fine to me.  My TM signal tests still pass on
> next-20130221.

I think all you (or Al) need do is mention it to Linus when you send the
pull request - he is usually smart enough to fix these things :-) and
likes to see the interactions.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Fri__22_Feb_2013_08_30_23_+1100_MGAb3sp07xvf_BDy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRJpHvAAoJEECxmPOUX5FEhvUQAKLS/zHVwAgbSoHnVVtmojPp
UwxghN9cTSOET4E5Z6rcMQjNqCogNOU6lZ/FBU5S4qM9FgWGuK/ZodCy9pkfR1Qr
Oyy4ilpduIOqoCUVt7zrVcZkSe6Uoc6w0r18s/4NzNhGtVpROelFsDOJ1Rjy7LtS
69O9k3pYaBOXxO1bP8E9zQVLnKNbzFiMAGPd0DqGxCn4oo4NvvNZQHnMWwredlJH
pEyB0YXxKCZ+LZHSVMHuyost2YuWEDGFchZM0aG4qXHIJYY0mMrP+40KmO8AcCUg
wJsVdJ1suXS9fani4I9o7awbQytDTFoF+7EDW8oGptz2Q9f1JJoFfUzVc6oPdyiH
V7d+5rMdHH09vbhR4RimeVxugMMf2JGIR1r7Lf9D2Ca/W7Zj3qpZIf+K908Kfazq
XP+S+y2+6Tj+hjmN3GWz5ifG59vwWkAvgO4HZcvuhOlnFwA1Wsk4142SMOIu32jD
QnZPuoEDMlIzZwB+Uvbc0XOILplwAJe4N1LnRsQfml5lOL+zZMN5AiJqaM1syIXT
nyavphblHEsBLC/bQ33k6xrsen3cjA06czP7jcDHOjq6KlCgSm+y3KzhqKDXmkCE
+DTS2GumTsE4NPoJ43vvrQnaJC3+HpdwaeKHwye5z2vGb2UBGbAMY3AcCA8ax/RS
t08Jx2AU+Yf7OKZ6mPJ2
=382Q
-----END PGP SIGNATURE-----

--Signature=_Fri__22_Feb_2013_08_30_23_+1100_MGAb3sp07xvf_BDy--
