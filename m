Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E07AC67A70
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 08:25:07 +1000 (EST)
Subject: Re: [snd] looking for layout-ids
From: Johannes Berg <johannes@sipsolutions.net>
To: Ken Moffat <zarniwhoop@ntlworld.com>
In-Reply-To: <20060525221111.GB27181@deepthought.linux.bogus>
References: <1148553785.11759.12.camel@johannes.berg>
	<20060525123247.GA19308@deepthought.linux.bogus>
	<1148560908.11759.25.camel@johannes.berg>
	<20060525221111.GB27181@deepthought.linux.bogus>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-+lEZKiRToRPBERmecMGY"
Date: Fri, 26 May 2006 00:24:51 +0200
Message-Id: <1148595891.11759.48.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-+lEZKiRToRPBERmecMGY
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-05-25 at 23:11 +0100, Ken Moffat wrote:

>  it seemed to build fine with this morning's git.  There were some
> messages during the build which might be important (I'm using
> gcc-4.1.0) but I guess they are probably standard alsa things :
>=20
>   CC [M]  /home/ken/snd-aoa/soundbus/core.o
> In file included from /home/ken/snd-aoa/soundbus/soundbus.h:12,
>                  from /home/ken/snd-aoa/soundbus/core.c:12:
> include/sound/pcm.h:59: warning: =E2=80=98struct snd_pcm_substream=E2=80=
=99 declared
> inside parameter list
> include/sound/pcm.h:59: warning: its scope is only this definition
> or declaration, which is probably not what you want
> include/sound/pcm.h:60: warning: =E2=80=98struct snd_pcm_substream=E2=80=
=99 declared
> inside parameter list

Nah, those should not happen. What kernel are you building against?

> i2sbus: !!!!! WARNING !!!!!
> i2sbus: control: couldn't allocate resource
> i2sbus: going ahead anyway

That's fine. Everyone gets it :)

johannes

--=-+lEZKiRToRPBERmecMGY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHYusaVg1VMiehFYAQLrBhAAsFTeFxIcqPG638UbjKIHXAUZMUcTMUsL
jfv6Ga8LaKK++NeB90qeRIhcJKBEOJ07MDknb/IWe0lda+iJ9qPn9KJeMskILXr5
bQDUkcC3DnZbElLS7zcv2e62F93dQ2DeWI8A1vIRLyzhg/dmoXdPaQZA+sTErjzm
+kJquhKuz73wBinSzv9hH/XTrDIyTpwql9DXQi0BeO3krxR3LhBMPj4vxwBwvWZt
EtdqZ642NtdQ4MLzGfa7sQOQBchR+w2Qarxp05l5Qe0knuplgwMheDWZLPQXO2+x
t9M1Q1pCTd7Qe8bGvHK2XuuDliTe6Fvp1QUUjwpYvG3viQ9y+H9b/Us5Q3bBr3nr
OH74ex05KgVAtScEliVCyG+/u3IDqBHhuBX+0saLC8+hEHRTcn2FoGE/+/1CwgXl
P2RAtk9Fruyw//EqKJRIYVeesY94cpQykW8Uy5fIcWgZcan6lwP9j5ODp2vrQ5qg
ipCw41/6x8/T73K3pl98yblyVgXJOjgPqRbtj5JjoonsQW3Tmv69xD2pFm1Sw5IS
jEbRRwWGhT+tPFdZwT/XYkUTQ7ckFtR8z/3Wf2+vTMDSRzqgSTJAIWqeToJZNkDc
AkrkgB/EYCVKqudki+4Kr+LQGd2OD4TUMdkzMfOeUsl3IiscUWm4C16wxwaTACTx
5j2EEisVA98=
=Alu1
-----END PGP SIGNATURE-----

--=-+lEZKiRToRPBERmecMGY--
