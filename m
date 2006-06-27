Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DF38867A3F
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 03:40:30 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC 01/12] snd-powermac: no longer
	handle	anything with a layout-id property
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hac7yvfhe.wl%tiwai@suse.de>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130910.156412000@sipsolutions.net>
	<jey7vjiqwv.fsf@sykes.suse.de> <s5hac7yvfhe.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/tV7irgxwbmlL62FX0CB"
Date: Tue, 27 Jun 2006 19:40:18 +0200
Message-Id: <1151430018.597.25.camel@localhost>
Mime-Version: 1.0
Cc: alsa-devel@alsa-project.org, netstar@gatheringofgray.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-/tV7irgxwbmlL62FX0CB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-06-27 at 16:29 +0200, Takashi Iwai wrote:

> What functions are missing?

I think Andreas is referring to the fact that the device-trees on
PowerMac7,2 and 7,3 are broken and hence snd-aoa-i2sbus doesn't work
properly.

johannes

--=-/tV7irgxwbmlL62FX0CB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARKFtgKVg1VMiehFYAQKSXg/9Ef0JSA8ehuKA0c5Rjc3DwB3l4XPB1WV1
7nJTQu3LkpVBueKfdt45LMxVuFGeXsgeFEEualEbx/K8QRApZqrvDylub2SKL07D
lee6BOkWVKEpPFFeWpJarm4arB+yZ3zpUJyfRAKQW99tMFzdQl006JWIRX773ATP
ZaJx+E3/F3tPFEO/WZMYCfXAi1sZjQ1jipCxcugB/fVjDQ5BNjzGGYboxhHMbw6p
B/NuMck4CdvIAsUAniKEqa6Ch6M2jWcg1tjC8xCbsG53sGeFlcHFHqDyjrw2EPn9
5bAzeIe6f/uE0jqQXIW+ynzkNfTWCoNssnfrPr7jD6q0rc2gFF0rlqCTWew04ezI
bA3nQb1evOAtfw0CaxLQydXNf3YhDPkjPAzXVUQS3uXlXhjb20mjLordpgo5xxxC
mIzAvCaLAifCE5YrGG8YIjz/ZCH3Yat6OpMTANZpMV7DR/ZRUZjkzS3Kd+mPZ5BU
Ljfaa+Up7b0QZzm08YnzA6Aar1e1S/aQ2QllgwpPYZPizqtz6IwEKWGlUoLfSrsV
ahkVvVZhW9IxCNphJcw/C3ljQs3cqwe0jvyOQLQMvLA/BYIHgh2cp2oBYmeienSc
QjkQo4N8HyNKPITlP85PXCLNbfJIxQkjkwQZ/XPUexGItHHPxII8KPebdUxoS44f
8AgX9OBjVWQ=
=s1L3
-----END PGP SIGNATURE-----

--=-/tV7irgxwbmlL62FX0CB--
