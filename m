Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA6D467B6D
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jul 2006 23:11:29 +1000 (EST)
Subject: Re: [PATCH] Make snd-aoa cope with lack of line-output-detect property
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17586.19091.512322.908434@cargo.ozlabs.ibm.com>
References: <17586.19091.512322.908434@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-hSSt/oVgDMdw6pST1sQX"
Date: Mon, 10 Jul 2006 15:11:22 +0200
Message-Id: <1152537082.30697.37.camel@localhost>
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


--=-hSSt/oVgDMdw6pST1sQX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-07-10 at 22:39 +1000, Paul Mackerras wrote:
> The snd-aoa stuff falls over on my G4 powerbook (1.5GHz Albook) with a
> null pointer dereference in of_find_property.  It turns out that this
> was because it couldn't find a device node for the line-output detect
> GPIO.  This patch fixes it.

That's interesting. I thought I was running this code. Hmm :>

I should probably drop the get_irq function completely and do that in
line. And yes, that should be NO_IRQ I guess. I'll prepare a patch
later.

Thanks,
johannes

--=-hSSt/oVgDMdw6pST1sQX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARLJR+KVg1VMiehFYAQL6zw/+JxgM4NgckBV1Rc/+z4gZX0ftsLS/TEdU
xdPveq4mJ8hyYOL3SS5ClRynie58Jm7SWcnkNds4J4t2yUceaISQhtmjS3eZpkhH
Na1DBZZlrKDu43uo3QsyGp5FvnT4WBDTZnnl8W2b35nceacHoNoFdEv0sOJWBn1N
/3C2eu0xznKZZN0whwr2itgRjr+nv7hWUH1y1hp3lblEFRRHFDb/sQdHG3Fnvmgj
EVfCfJ+xdJH2pwUBhv7ABw+Pbg23QMRni9ALARP75TAA5TO3z+EIGrq/KkGxckNX
Kh4ZTC3T4/LCIhECInwe+qOa2Xz1vwfyEYaVSluQGw4ZekfsG37qPckqg8Y4AZwI
gj87u9qD2hKocfZbXPCwFfadrTXgbwhKYLJYIaEYyGLbAP4/t6d+KobNo3jz4u2A
ydWtlsEch6F4iElQard5IMkoXu023YO95jwS1bJsaru2cSBk0k973hklp3Fom80N
sTTzbTP9ai+ToJuqkcEeFqUkGMFc81ICjadot3WFRkbCjys8Y4Gw5MzdE/HlBSXW
dJ4G8gnvBFb8spDOLiXkHKSq79A7SKlcbG12VLsFSk+S6D/cK3U9YwhNYS+AgYjK
ECJpU4kKTt53OpuBH5remFBI5HQj2xO7L/d0Zwct8FwG86L1dppKIRbNiVagNw1+
X0KO4C1HrQs=
=PW4j
-----END PGP SIGNATURE-----

--=-hSSt/oVgDMdw6pST1sQX--
