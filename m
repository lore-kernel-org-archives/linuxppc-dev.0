Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A99D1DDE18
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 21:30:02 +1000 (EST)
Subject: Re: PReP residual to device-tree converter
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1215600470.3670.35.camel@johannes.berg>
References: <18490.22494.511244.977267@cargo.ozlabs.ibm.com>
	<1215600470.3670.35.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-WxTCZXjzUyBpgmTp/NWO"
Date: Wed, 09 Jul 2008 13:29:12 +0200
Message-Id: <1215602952.3670.39.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>,
	David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-WxTCZXjzUyBpgmTp/NWO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-07-09 at 12:48 +0200, Johannes Berg wrote:
> > I would like people that have PReP machines to take a copy of
> > /proc/residual, run this program on it, and check that the output is
> > sane.  If it isn't, or if it is missing bits, send me the residual
> > blob with a description of what's wrong in the generated dts.
>=20
> Here's the output from qemu:
[...]

Milton wanted iomem and ioports, I didn't manage to get userspace
working so I printed them in the kernel (hopefully correctly):

iomem:
c0000000-feffffff : PCI host bridge
  c80000f0-c80000ff : 0000:00:01.0

ioports:
00000000-007fffff : PCI host bridge
  00000000-0000001f : dma1
  00000020-00000021 : 8259 (master)
  00000040-0000005f : timer
  00000080-0000008f : dma page reg
  000000a0-000000a1 : 8259 (slave)
  000000c0-000000df : dma2
  000004d0-000004d1 : 8259 edge control


FWIW, my qemu command line was:

qemu-system-ppc -initrd initrd  -kernel linux/arch/ppc/boot/images/zImage.p=
rep -M prep -cpu 604 -serial stdio

johannes

--=-WxTCZXjzUyBpgmTp/NWO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJIdKEBAAoJEKVg1VMiehFYV3gQAIhHJXPJ1/TTqTptVKZ2NblI
ozU8jjqjeU+MVSW4Yn+Tjl6skSx0esH2Da3jaaJlPgpjk4hGOoO5ZH4AWzOOXLnw
a/Jvg9Kp+CUzF3hM2A25sQ2/MISlesCvdheJsQxdzF0NK5Su0wzXU4CKMxvYMAo3
QCgl0StQVoznMS8B1sT4oEULkIvuKY6wkhIZsG15Mf8V3AVmtZJX82PdNjIgeZmP
nl/CXq0M/YD+qwILfA3TACmjMDNv23GDnYNGkLenQTFonJBu8wN9K20KHe1w/Y+0
nmfW1EK68OxjVOb8rXAV0g6iZzoz/mryFijAK+g2CDz1KCp4NLEEZT1zyqgtv/yq
gurqLAf3nXtKJOvP6yLXoOqbc9EAGDlE8eGEmdlSoyzYkbA5deKDWOHDOiJDegj6
tqOFQIWsDoultA3h0BCTtfhHLkVi14GIdfvf6kth6hDnRTT6+hpVIsbZHT3YMPug
uc+FVfqci2b9OmMP3VHdZaOjtPHtNUCmK4R8EE8UfHlrZQLz85LVtielsvHGTKrn
xBEd6jr/s6A/OxAoH2+fWTy/TWmfChj5CLB2/Ch79/R/0j5Kjm341Bgp6Cz/v740
wyNf5nPCzcmweRMD0anvKgL03CBYYA5ZSVpnAOWaBM0BKMReDspHt1l+qwiOfCtH
+dPOTQf4Hj7MJzplvYok
=97TS
-----END PGP SIGNATURE-----

--=-WxTCZXjzUyBpgmTp/NWO--
