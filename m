Return-Path: <groug@kaod.org>
Received: from 1.mo2.mail-out.ovh.net (1.mo2.mail-out.ovh.net [46.105.63.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtmNJ4btwzDrXc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 16:54:22 +1000 (AEST)
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id C9329AC03C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 08:54:19 +0200 (CEST)
Date: Fri, 15 Sep 2017 08:54:08 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, Paul Mackerras
 <paulus@ozlabs.org>, Sam Bobroff <sam.bobroff@au1.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: fix oops when checking KVM_CAP_PPC_HTM
Message-ID: <20170915085408.7709143d@bahia.lan>
In-Reply-To: <20170915075249.0e9879a4@bahia.lan>
References: <150542618501.6859.11512107352972110416.stgit@bahia.lan>
 <20170915004839.GA5250@umbus.fritz.box>
 <20170915075249.0e9879a4@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/th1WyJjunlnkqbIo3FPJXtG"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/th1WyJjunlnkqbIo3FPJXtG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Sep 2017 07:52:49 +0200
Greg Kurz <groug@kaod.org> wrote:

> Dang! The mail relay at OVH has blacklisted Paul's address :-\
>=20
> <paulus@samba.org>: host smtp.samba.org[144.76.82.148] said: 550-blacklis=
ted at
>     zen.spamhaus.org 550 https://www.spamhaus.org/sbl/query/SBL370982 (in=
 reply
>     to RCPT TO command)
>=20

Dumb me! It's the opposite... OVH is blacklisted by smtp.samba.org :-\

Sigh.

--Sig_/th1WyJjunlnkqbIo3FPJXtG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbt5EQAKCRAC/DrrAQHb
wgXRAKClpE/Wf/H1MDdG0xutEd1mhlVAIQCeKmLoBO6HNqEKQyR4liTU363cSSI=
=AkoJ
-----END PGP SIGNATURE-----

--Sig_/th1WyJjunlnkqbIo3FPJXtG--
