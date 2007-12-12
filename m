Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F39DDE188
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 04:36:01 +1100 (EST)
Subject: Re: cpu frequency governor regression (?)
From: Johannes Berg <johannes@sipsolutions.net>
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20071212173001.GA18973@redhat.com>
References: <1197399165.2214.15.camel@johannes.berg>
	<20071212173001.GA18973@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-xRJEQZucJZe0bkqiWDtV"
Date: Wed, 12 Dec 2007 18:35:43 +0100
Message-Id: <1197480944.6558.132.camel@johannes.berg>
Mime-Version: 1.0
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-pm <linux-pm@lists.linux-foundation.org>,
	cpufreq <cpufreq@lists.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-xRJEQZucJZe0bkqiWDtV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> bizarre. It should default back to whatever CONFIG_CPU_FREQ_DEFAULT_* opt=
ion
> was set.  (Arguably a bug in itself, as we don't track & restore them
> on resume, so if you changed from the default after booting: splat)

Hah ok, but it's still odd that it changes to a different one.

> Why you're getting the performance governor is puzzling though.
> Can you enable CONFIG_CPU_FREQ_DEBUG=3Dy, and boot with cpufreq.debug=3D7
> and send the log from a transition across hibernate?

Sure. I'll do it tonight and send it tomorrow.

> Also, does /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor=20
> have performance in *all* the cpus?

My four CPUs can only change together so I don't think that is relevant.

johannes

--=-xRJEQZucJZe0bkqiWDtV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR2Ab7qVg1VMiehFYAQKs6hAAks9cBP0FO8t/HSpv3TFBr+ZfSGsMht+v
gfKFD6yrx60druZrCQcRBvdszn1b3YrcsOaxJdC3fGOKlEzC8Ax6gWm17a/9iL+j
5AePB6LyAR1iklbRJgnRp7oFfYcubOi+FZM30V/ZYYSz1WJ6xGByg82txkl/eny9
3ryB6P1EouCoc7rgmvaBJb1Tq9M+KHyBOZRlQsq8vIqsUFWbgVA3idMpiZ6hgI74
9D+tZlE1p6HO7fyWnjTaanIQfv6QnlkGSs459A1GY1/PzYAvLoDFsxbjlWW/xHOg
PN8ZsF8Ztmo/PpKa77lzIgDypn9e86HvPGcpTRJaYPg9/VixlPHg/jd+3txMycX3
0NCe0sr6m+waFDnQxZ0XykFVVKrEVWxh6NIJpe2nVdpNQQik1KWrCwve9Hu3yzC3
MfE9HxRpPzsY0X2GiO5dXB8Mod5WDb7Bbjg1ghjJcBt7RWiUMrw1TeWFocoBT/Zi
sc8Yy2RN9wPW2/GXRaNsoTd8F8cnPWSful2TMh1iqcBkWyYFG3+uPXQmFEKp4FSO
v7MAFFICdgRo08euaiectRWW4BmZ/MAuOK9twxBH6RziL1QNISchAmwaK/81/M83
6UKJNiur9KKTPwiWTcmzx2/3yzrcW4CjHwGcKiD0HWuSUJvMbi1h2ALFSiMgPG6v
Amw7qvO7dQQ=
=6WvO
-----END PGP SIGNATURE-----

--=-xRJEQZucJZe0bkqiWDtV--
