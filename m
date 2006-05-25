Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F098967A41
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 00:13:51 +1000 (EST)
Subject: Re: PowerMac: force only suspend-to-disk to be valid
From: Johannes Berg <johannes@sipsolutions.net>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060525071013.21379ba8.akpm@osdl.org>
References: <1146562296.3858.9.camel@localhost>
	<1148551527.11759.10.camel@johannes.berg>
	<20060525070558.2b7e24cd.akpm@osdl.org>
	<20060525071013.21379ba8.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-KlpEEB+81xd9lM2YCPE1"
Date: Thu, 25 May 2006 16:13:35 +0200
Message-Id: <1148566415.11759.37.camel@johannes.berg>
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


--=-KlpEEB+81xd9lM2YCPE1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-05-25 at 07:10 -0700, Andrew Morton wrote:

> Please also explain whether this fix is needed in 2.6.16.x.

Well, for a very long time, echoing 'standby' or 'mem'
into /sys/power/state has killed the machine on powerpc. This patch
fixes that. So I guess yes, it is applicable to 2.6.16.x

johannes

--=-KlpEEB+81xd9lM2YCPE1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHW7jaVg1VMiehFYAQIz+Q//a66u2f7OWhAQqBE7rz3SzXww0jzx4Z8J
GApS3mGclAzYJSpQncYj5JPMxTNBdLVTpuYAPlyrPchPYGIyI9vl7lgndCC6zRvV
ne5mhq5dR7fwfHSk9N3C/XEmwLQr1auwh62JQa9tJVe9Y4TwXNDfN5UnW812/ecz
s+4b4a+r7N7LYaZoo8PokgRVB4HJNvJAArAwogE/tpdmKwzLPAOjo67v/sGLosna
dFnxTiRob/76NRu0n6HPms+zv3thFhuLIKlXTpS4vQDUJee4GhYUvEm5XnZelvYs
NHK1MQrs/0zua7Psux5DMJu5g/Q5irl5oLZhiKrYbhsI9erUS7UqnI3CigV92PAO
ziyf6bDLINW/l5Kr9ZOC3KSdgCsMDQY3Y+G7IJJ5zCwt9aExmDA62rp5incK1/Zu
KWKM9FWdOhHQO9QA9nMPEdDhRRbDgAG/kK1SeVco9Iw7IdBcQcyLuuDb5K/VOJkh
9IVJQ8dpUjhTJUDBzvKD+H7fjnimJdjUgrA+K5FagoY3f+UUg8hgHmVyb2aSSm2M
ClsNOzF8u9AMCTPFO8hvdzMCAh6idWZibUieXB5PsImpHl3Z7hgMRvx5pCHaHG4/
W3mA8lR8eNPfz7nF/6H1Y8/wsCDO3TewEl52Qnyp0nmeZZ4JEdWde6WrE2wKjAZm
jDOMpeZ10Ys=
=V+c7
-----END PGP SIGNATURE-----

--=-KlpEEB+81xd9lM2YCPE1--
