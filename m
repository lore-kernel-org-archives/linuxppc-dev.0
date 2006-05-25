Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 57DD867A44
	for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2006 22:37:17 +1000 (EST)
Subject: Re: [snd] looking for layout-ids
From: Johannes Berg <johannes@sipsolutions.net>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jefyiy9tds.fsf@sykes.suse.de>
References: <1148553785.11759.12.camel@johannes.berg>
	<jefyiy9tds.fsf@sykes.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-djb3U3C28w9W7pQljgwZ"
Date: Thu, 25 May 2006 14:37:00 +0200
Message-Id: <1148560620.11759.20.camel@johannes.berg>
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


--=-djb3U3C28w9W7pQljgwZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > In order to replace snd-powermac for the newer machines where the
> > 'sound' node has the 'layout-id' property, I'm looking for testers on
> > machines that have a layout-id [1] property with one of the following
> > values: 0x24
>=20
> That would be mine, but it has the problem of the broken device tree, so
> i2sbus doesn't work yet.

Ah, right. I'll have to check with Ben a bit more when he comes back. He
seemed to have half of a plan ;)

> > [2] Before you ask: I will not do this before snd-aoa supports headphon=
e
> > detection :)
>=20
> Another important feature would be DRC, IMHO.

Yeah, I guess, but that's only doable with the tas codec. I don't think
it's hard, if anyone wnats to try: the tas datasheet is in my
repository, and all you need to do is modify the tas codec to show the
controls for that. Could also use some bass/treble controls.

If we want DRC even for the other machines, that's an alsa userspace
thing since it needs a soft-DSP then.

johannes

--=-djb3U3C28w9W7pQljgwZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHWk6qVg1VMiehFYAQKWRQ/+PBxBrw9UdiSYB/aaVPU+98fGCdE4cj4V
upIypoWRsuOhJXDqB35Sy63eZtUcpG5EOc/FNI6vmnixlc5m1p1wOqEITMkfAXB5
/dB30VzVgicWmZKushqIR9guxezHEG/huA1uInfmDWBPex3e2T3VTu6CvK4lRfdP
58XwK3mB/kSsj2y/iyqsFuJ06DhLwNDAho71eeywlSkr2iABYU7jIOJdmnOm1ah/
t0icoaJsZFo/VtPVvK4dIdPLC2r8/CxrghmqRDQyeAZCuhLQw6rgnOFtFLFobl2Z
V2UqI3K6x7OdJfnz9iP9oRjJMbrtKga84sBdYQgAB0/RqGb255X017h8MoN2ghgm
ecPgl9s9txJ9NHdnfSz1FfvQRgHInGFpJz2B9b0+x2VDsU6E1RGML69C36ln1vMc
oo1RfOvnhLzxw2yrFjgZivSPG92uzBZykxViDXD0IK1HnWdb1qLpSO024s/r4IFe
JHvLwcejhTHVBVM3AYM6qKf/vO4IHSah7xdo9l5/d+tMhAlokOt3r1buzDziyoBn
exzMCnHUKQUCEMQkwX0DqGliZmgo5M4RdxIqQEQ5j5CeWg4WS2SItLsMDb+jh1Xv
55tt1WNi2K2IQ5chXKVXZQDgfR9rzD9wMkcMRU+cmaqhZDjdlxZk2SFffb8ORbyr
UE2jTt7R7W8=
=MuSt
-----END PGP SIGNATURE-----

--=-djb3U3C28w9W7pQljgwZ--
