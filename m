Return-Path: <jjdanimoth@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id 0C3D3B7D11
	for <linuxppc-dev@ozlabs.org>; Wed, 19 May 2010 05:16:10 +1000 (EST)
Received: by wyb40 with SMTP id 40so19338wyb.15
	for <linuxppc-dev@ozlabs.org>; Tue, 18 May 2010 12:16:08 -0700 (PDT)
From: JJDaNiMoTh <jjdanimoth@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: PATA/legacy IDE subsystem on PowerMac
Date: Tue, 18 May 2010 21:16:00 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart19912364.T9ebXIZepk";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <201005182116.04092.jjdanimoth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--nextPart19912364.T9ebXIZepk
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I hope I've posted to the right list.
I'm the maintainer of the linux kernel in ArchlinuxPPC [1].

We actually set statically the support for the PowerMac on-board IDE suppor=
t=20
(under ATA/ATAPI/MFM/RLL support (DEPRECATED) ), and the disk is recognized=
=20
correctly (hda*).
If we try to remove this legacy support, enabling Serial ATA and Parallel A=
TA=20
drivers --> Apple PowerMac/PowerBook internal 'MacIO' IDE (NEW) statically,=
=20
the kernel doesn't recognize the partition on the HD. We tried different=20
powerbook, and the result is the same.

Because we haven't log, I take two photos [2] [3].

With legacy stuff, I used hda6 as root device: with PATA, neither hda{5,6,7=
} or=20
sda{5,6,7} work.
As you can see from the photos, seems that the hd isn't attached to any dev=
ice=20
under /dev.
With request I could upload somewhere the configs (working and not working)=
=20
used, but they differ only for the things above.

Please let me in the right direction.
Many thanks to all.


[1] http://www.archlinuxppc.org
[2] http://img268.imageshack.us/img268/5787/dsc04701x.jpg
[3] http://img204.imageshack.us/img204/6476/dsc04701v.jpg

--nextPart19912364.T9ebXIZepk
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvy53AACgkQEuvof5soqdIwYQCfVAlQCr42rQ7qBZ5D5Zi98MnG
qukAn3M5SIVsx8mPp7JLOI5hdzRiw6Qk
=m7pS
-----END PGP SIGNATURE-----

--nextPart19912364.T9ebXIZepk--
