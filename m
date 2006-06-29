Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 927A4679FC
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Jul 2006 02:52:16 +1000 (EST)
Subject: Re: [linux-pm] release early... powermac g5 suspend to disk
From: Johannes Berg <johannes@sipsolutions.net>
To: Pavel Machek <pavel@suse.cz>
In-Reply-To: <20060628214217.GC30373@elf.ucw.cz>
References: <1151057810.7608.25.camel@localhost>
	<20060628214217.GC30373@elf.ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/fHW3lXz/wGv10x8BYpy"
Date: Thu, 29 Jun 2006 18:24:00 +0200
Message-Id: <1151598240.17705.11.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-pm <linux-pm@lists.osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-/fHW3lXz/wGv10x8BYpy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> Congratulations! Hehe, you have nice testcase for xfs now :-).

Yeah, already posted to xfs list ;)

> [ext2 is the filesystem you proably want to use while hacking such code].=
=20

Mounting read-only hasn't wrecked it any further so far :) And I was too
lazy to install a second system... Should've, I guess, hd is large
enough anyway.

> > Half of the time I'll be told by the softlockup watchdog that it locked
> > up, but sometimes it actually works, that is, it suspends and resumes.

Obviously that was phrased wrongly -- the code hangs and the softlockup
watchdog indicates it. But I don't know why. Can writing the MSR hang?

> I believe this is gone in -git kernels for some other reasons.

I'm not even sure the hack I did there with marking the area as nosave
is good. At the very least the code shouldn't live in the MPIC file
since the code reserving the chunk doesn't either.

What about the page_is_ram() part? Doesn't any other platform have a RAM
hole between 2 and 4 GB? Or is that handled more generically with
discontig support? (and if yes, how does discontig support work?)

johannes

--=-/fHW3lXz/wGv10x8BYpy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARKP+nqVg1VMiehFYAQJnMw/9GXmZK1ql/5NzKO3gM5yJvPyIBjpCBkFH
0M3iCeohIVXGx3tScdMSDZamqSLotdsBGI7JqI+pWFFC+NVlTkrVIUGB/iX98aeI
BC+tXlWr4xY7VIm+E9SCzfAMyYc+6GXTejS6n3umVVpl9sd9sb9r5s1mYIaDa+ZF
NYmN0GV9EpIT/c9/rA9k0ueWUP/5w66KoKVuFPGqfLiA77bOA9GgAzPevgmCNPiQ
Lqa4+ExLJbCxZIFW15Xrz1VCh9GSw/Pvam3h3z11olRpKSs+DzlLHEC9svBjQs7H
TFym3QLnZPjffIEKczPOoNDHWe4LQUysVHGn4D15U97mbuW9ObuKjO3eUk29duYq
ElagSUfXdwJKMAIizD0mPedbYCMPBqEVpPPZG5lM/NDJMIfGJVFMzyzzqNhL+8pM
lVXhIuiP0Pgj76E7agGLYaGB2K1ENrZlybxpTxvTVP9uwXfad+Vq1cHI9cGTIroH
edaC2NcC6HQF1Stt9SWqYgfeWA+Z58DJMuDt9+qdwFK5lDdwdSCREa/35Gps8VZb
UebsLDU5RfMv2Lcm8pzqAsGvr1a7wlZwu+pyqR4H3XGHhcToVRBZRYgeG/6A9HYZ
YDIwCbzoL7Eeoyj69SyEQiz4rtL7Sgjre+76BacA4GWS2ZbfejheGLDmxp+N55M5
FyQ/9dkyxrs=
=zJ7e
-----END PGP SIGNATURE-----

--=-/fHW3lXz/wGv10x8BYpy--
