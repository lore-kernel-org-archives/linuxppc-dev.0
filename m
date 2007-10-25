Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6B922DDE32
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 23:37:43 +1000 (EST)
Subject: Re: ioctl32 unknown cmds with 2.6.24-rc1
From: Johannes Berg <johannes@sipsolutions.net>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200710241627.18284.arnd@arndb.de>
References: <1193229045.4510.35.camel@johannes.berg>
	<200710241627.18284.arnd@arndb.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-nAoNggv98zXqRzHeC2Rt"
Date: Thu, 25 Oct 2007 15:38:37 +0200
Message-Id: <1193319517.14136.2.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-nAoNggv98zXqRzHeC2Rt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-10-24 at 16:27 +0200, Arnd Bergmann wrote:
> On Wednesday 24 October 2007, Johannes Berg wrote:
> >   Show Details
> >   I've been getting these warnings (many more of them but this is a lis=
t
> > of unique ones) on my quad G5 with 32-bit userspace:
> >=20
> > ioctl32(cdrom_id:1078): Unknown cmd fd(3) cmd(00005331){t:'S';sz:0} arg=
(00000000) on /dev/.tmp-3-0
> > ioctl32(ata_id:1095): Unknown cmd fd(3) cmd(0000030d){t:03;sz:0} arg(ff=
863970) on /dev/.tmp-3-0
> > ioctl32(smartd:3563): Unknown cmd fd(3) cmd(0000031f){t:03;sz:0} arg(ff=
eb5480) on /dev/sda
> > ioctl32(hald-probe-stor:3761): Unknown cmd fd(4) cmd(00005320){t:'S';sz=
:0} arg(00000004) on /dev/hda
> > ioctl32(gnome-terminal:4187): Unknown cmd fd(19) cmd(0000530b){t:'S';sz=
:0} arg(0fd8e400) on /dev/pts/0
> >=20
> > Does anybody know whether this is expected?
>=20
> It's probably my fault, since I changed the compat ioctl handling for
> block devices. Geert already reported the same, but I haven't had
> a chance to reproduce it on my system to look into what went wrong.
> Probably a trivial bug I introduced in block/compat_ioctl.c

I have to admit that ioctl numbers scare me :) Any idea what I should be
looking for?

johannes

--=-nAoNggv98zXqRzHeC2Rt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARyCcXKVg1VMiehFYAQLO6w//fSeIphlLHw8Jug1flYIW/BUIMx3qx8sq
4ytG1BuUoBQEGQ8bqxtoGAWl8p6ndZqf9dU/mC7um8k6aJiEBYm2bSGlBGj9nOzh
rzjqM4EPIKQ0cxjXw2fP/m0Sx64QRDue+ayXSGD6SY0saIidyeQuyW2F8B1/lRsp
lsNgbLf2ZPV6dqAIWbvPoKXMK4Yb1luyhRP1Cx+mo152850WX800juPDdjjUW8Fs
+M2ULu50xLMVSV2QsVIFdPegNPEHBTDT2piVlAMEEe1B+KUqN1qcNzfmAyo1UR7K
XYmziEO7pWerqsAa6Hlmx+RuwIOw9XoIRpJX5aq6y9civC6WtxZs9DIRZ18eCLOo
5IymszWFg0nFlVQdLb2iGGlNyVZAC7zv61pAOxpmrXgv3M3s0zXrF67On/+EV2Ht
kY3IMTKAf++kQn45M+Lk8fXjrztN+f4UOkRHa6Ks1pl66zrKRbMwfWyZSnKA4qFP
MiPK53Mq7cDfnNK4sozhs40kGmqDKXHQU2dzpZi8dllrhXaLul2hwJuVnyFJqbHT
MyHbg1rnSW/Rxm6oNNYsLI5i+TZy8nPg81Gtq2GFVPqJzO2rBtZb5xCG/doK7mDr
RVCqBRxQ0EPfGOw9auraw4qc2IeRnpsk3jzrpu8QBefs7NPGPfeTHC8hCtJwcnfL
2dMFvrMh0D8=
=hnmI
-----END PGP SIGNATURE-----

--=-nAoNggv98zXqRzHeC2Rt--
