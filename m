Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8B87BB6F0A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Apr 2011 14:49:06 +1000 (EST)
Date: Wed, 27 Apr 2011 14:49:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: ibmveth runtime errors
Message-Id: <20110427144901.4c3f79b3.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__27_Apr_2011_14_49_01_+1000_U8FawZUyRrxwMQdK"
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	=?UTF-8?B?Ik1pY2hhxYIgTWlyb3PFgmF3Ig==?= <mirq-linux@rere.qmqm.pl>,
	linux-next@vger.kernel.org, Santiago Leon <santil@linux.vnet.ibm.com>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__27_Apr_2011_14_49_01_+1000_U8FawZUyRrxwMQdK
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

For the last couple of days, linux-next booting on a few of our Power
partitions (but not all) have produced this error (over and over):

ibmveth 3000000b: eth0: tx: h_send_logical_lan failed with rc=3D-4

Linus' tree seems to boot fine on these partitions.  The only commit
directly affecting ibmveth in linux-next is b9367bf3ee6d ("net: ibmveth:
convert to hw_features") which first appeared in next-20110421 which is
also the first one that failed.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__27_Apr_2011_14_49_01_+1000_U8FawZUyRrxwMQdK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJNt6A9AAoJEDMEi1NhKgbsyDoIAJt0BwBVs35qIsH/QAWt9poW
aOerprGkeHdYzu95nZDvXgwjz05s5hhcvWK/JlAZCvtcXGqbLsE9CU0TQQ17kSW3
nXTdl15gfzIu3gTg/XfpCy2cmJ7/1v16IDdB8mKhynZDOmlfA/y8wtkRITIM4Ph8
Ez4vNH7SfeyZCp7wWNndTnK5kWHCAOuP5YsGxt/qFl5folwuMqcyEs3HdfQwRj8h
396FAGRQg4vRQKKsR6oa1v/FfgCYW1zbsvAAE4vIFKtzj7aire/632v7UKsQHDNu
emL2dSoH+GMI2j/GUFe64xJb4SZ7d/3vXkJ34p+FgJHox6io1u8qzCl/UtycCDY=
=2HqB
-----END PGP SIGNATURE-----

--Signature=_Wed__27_Apr_2011_14_49_01_+1000_U8FawZUyRrxwMQdK--
