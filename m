Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 40AB8DDF08
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 20:57:06 +1100 (EST)
Received: from smtp.belgium.cse-semaphore.com (localhost [127.0.0.1])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id 7752318839
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 11:57:00 +0200 (CEST)
Received: from pingouin.belgium.cse-semaphore.com
	(pingouin.belgium.cse-semaphore.com [192.168.1.47])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id 5A2AB17895
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 11:57:00 +0200 (CEST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: Floating inputs on unused GPIO pins
Date: Mon, 13 Oct 2008 11:56:56 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1500244.VMzYZTGgD8";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200810131156.59477.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1500244.VMzYZTGgD8
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

our hardware engineer asked me to make sure all unused GPIO pins are config=
ured as outputs to avoid floating inputs. He got theory on his side (floati=
ng inputs can lead to higher current consumption, metastability or even per=
manent damage), but I'd like to ask the list for practical feedback.

I haven't been able to find any mention of floating input protection in the=
 MPC8248 documents. Has anyone here experienced issues with floating inputs=
 in real-life designs ? Do you setup your board with all unused GPIO pins c=
onfigured as outputs ?

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1500244.VMzYZTGgD8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjzG2sACgkQ8y9gWxC9vpcVSACgyTjaeMQpRB+q4UQM7vHwMZzH
lpgAn0GTqY1JzTcCfFIMKGDw0zjMRvzt
=Zq0b
-----END PGP SIGNATURE-----

--nextPart1500244.VMzYZTGgD8--
