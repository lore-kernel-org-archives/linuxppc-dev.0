Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 94E0367A05
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 23:48:35 +1000 (EST)
Subject: Re: PowerMac7,3 sound (was: PowerBook5,4 -- no sound?)
From: Johannes Berg <johannes@sipsolutions.net>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jey7wynnux.fsf@sykes.suse.de>
References: <878xq51t61.fsf@briny.internal.ondioline.org>
	<je1wvxo70l.fsf@sykes.suse.de>
	<1145220233.9833.11.camel@localhost.localdomain>
	<je7j5phz9j.fsf@sykes.suse.de>
	<1145231658.9833.17.camel@localhost.localdomain>
	<je3bgdhwre.fsf@sykes.suse.de>
	<1145233812.9833.21.camel@localhost.localdomain>
	<je1wvwfh7s.fsf@sykes.suse.de>
	<1145307118.3912.11.camel@localhost.localdomain>
	<1147862072.14395.25.camel@johannes> <je3bf85twf.fsf@sykes.suse.de>
	<1147948758.15507.52.camel@johannes> <jek68jqz1l.fsf@sykes.suse.de>
	<1148042866.3864.3.camel@johannes.berg> <jey7wynnux.fsf@sykes.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-wEaj5+PxDwdcuO70Su/V"
Date: Fri, 19 May 2006 15:48:32 +0200
Message-Id: <1148046512.3864.17.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-wEaj5+PxDwdcuO70Su/V
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-05-19 at 15:30 +0200, Andreas Schwab wrote:

> >> Yes, that's while I had that loaded.  Of course, I unloaded it before =
I
> >> tried snd-aoa.
> >
> > Ok, but is that the correct stuff, i.e. does it work?
>=20
> Sorry, I can't quite figure out what "it" refers to in your question.

Sorry. I was trying to ask if you get sound with snd-powermac, i.e. if
the items

>>         80008000-800083ff : 0.00010000:i2s
>>           80008000-800083ff : Sound DMA
>>         80010000-80010fff : 0.00010000:i2s
>>           80010000-80010fff : Sound Control

are correct. I'll have to investigate a bit more what happens on your
machine.

johannes

--=-wEaj5+PxDwdcuO70Su/V
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARG3MraVg1VMiehFYAQLT3g/9GkLblbdgqWAWU3dkMugVI+fkB+b1Xcw9
iWVZaPf62nGRaATPFlXZWig9UvOgmgAyr6yFgfEN/tgtPbUCapnlGsE6ps0OZWPh
nx1kRnPKArrAFdr7lEe5oFz41oAKT0HuiXAMuVW+EGIm9AiaeyfiHBNdIAE/o0lB
HXa6qZWIfsCj8FV10reKGsdI2LYgxAkz1owqvn2uJ2DWIXmJb7eUt4ANo1u72ZNJ
95UVmBziI5z2tKkumAXcmd11kzLBEaG2dU8tTj79y1vciKVb82OgsNa1ZPUm4cG8
kfESeHBvhFZJtAaEPLZ5Qo+TCJaic3SzfquNiVW8t7PLChXFM69lCUORyGV+mnGG
TpoDjcz2f7YZFskJWBvIXY2OqmSbenLp46wbd/I108EbaH1wGKh3SWURHZQchbjI
Pp9Astlj/eCKNfQW+/IqAvi8E9t1DPWB54DQeid2vwUaWy2EaHeT43DcYr1tCkaJ
o/e3lKh/Vdg8mCCkaALn6l3xTGjjeTcAickweTsJDkFAMxljK33YdJZAVOhEDEhS
X/on+PM71ZHMx8wIgfdXOwBY9GpWdz6LYM9PUg/7PqWdMEy+kEHVij8ReSM3rqf+
W6lRbpFlWjOnjnKEE+U/hiCmUb+TXadeHnK1Va8UnvTtWpmOMfcobBVlOusAjtbp
XFZikSbpiY8=
=23Q5
-----END PGP SIGNATURE-----

--=-wEaj5+PxDwdcuO70Su/V--
