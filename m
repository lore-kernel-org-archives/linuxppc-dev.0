Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4375367B4D
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jun 2006 21:42:06 +1000 (EST)
Subject: windfarm got signal
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-TyYiAJUUqNiSlVFUpOdW"
Date: Wed, 21 Jun 2006 01:51:22 +0200
Message-Id: <1150847482.16662.13.camel@johannes>
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


--=-TyYiAJUUqNiSlVFUpOdW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hey,

after cpu hotplug I decided to write some fake suspend routines for
ppc64 that always fail to see what all the drivers would say... The
first thing I saw was during the phase where all threads are stopped,
that windfarm got a signal!

Shortly after that, the fans were revved up fully but I guess that's
expected if the wf control loop exits.

So now I'm trying to see *why* it got a signal there. Any ideas? Is that
expected with pm and windfarm just does the wrong thing there by taking
the signal as a reason to exit the control thread?

[code in question is windfarm_core.c:wf_thread_func]

johannes

--=-TyYiAJUUqNiSlVFUpOdW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARJiJ+KVg1VMiehFYAQJKDg/6Aqi/XqErCaFSwdPMiR+qzEq3XRECUp6X
eBNesiecBU156iJLNWDiiK55W9lbyPZl60GtNUzVQe2W8HzpjcXrujBWZgc9JMIg
6dbk/5iQhzaCP4+l+NO/5W30De1fMzdoGecAzuUVJcr4I5jDE1KiqMYPV61W/DhO
yCJagzGPv5LwS+1l9KZhDAIa/KrtLm3/SkDgUA9aYoiEHF6NjTTgWfvrmqqhosqh
WLwMAsAaj6L5E3hxzsByCER19e7+9W4AWPh4ZCq/Gp8vAfIFstis5X9u5mjHuISh
PUG2Y/zDrhIy3jWdakZMpe5TSNmJa8rohhofxhVo0YWV9NF2SoWFes9yTPRo32IB
9bBPyHJvtl50l3f7JF3EWuxW8wxfIExda4fZfLOk4qoMdz5kmLUib9g6VD+1TBwM
7uz+D9hOxBrDRIRJSQsWrWxiTNAlAgsyBtiAypbxoUG8M2S3VCNcRXTiRrKkf3Yg
6i2p111hRoXxW/BclM5TRo0+7R/MVo7zJ/A0Kqa6CblgmNJqop/FHxjw5XSs1ZEG
4D5/hfbkBtkEFHZYZR2kJkGYwN+DFnKPjj1EbKdoUjKxRwIkYyMjxj0zkflwdXoG
CWQONctaG/xI2yyG6qW1ctwqFa6dTawVZQEWzxo5pyUQz2lqS4N/PEPc/NUqQIn3
i+l1belAfvI=
=zEDq
-----END PGP SIGNATURE-----

--=-TyYiAJUUqNiSlVFUpOdW--
