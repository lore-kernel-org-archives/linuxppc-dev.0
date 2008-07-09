Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5C7EADDFD6
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 20:48:43 +1000 (EST)
Subject: Re: PReP residual to device-tree converter
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18490.22494.511244.977267@cargo.ozlabs.ibm.com>
References: <18490.22494.511244.977267@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Kbm+XYQPW975nkUiPzNB"
Date: Wed, 09 Jul 2008 12:47:50 +0200
Message-Id: <1215600470.3670.35.camel@johannes.berg>
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


--=-Kbm+XYQPW975nkUiPzNB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> I would like people that have PReP machines to take a copy of
> /proc/residual, run this program on it, and check that the output is
> sane.  If it isn't, or if it is missing bits, send me the residual
> blob with a description of what's wrong in the generated dts.

Here's the output from qemu:

/dts-v1/;

/ {
	model =3D "Qemu";
	compatible =3D "prep";
	#address-cells =3D <1>;
	#size-cells =3D <1>;
	serial-number =3D "";
	clock-frequency =3D <100000000>;

	chosen {
	};

	cpus {
		#address-cells =3D <1>;
		#size-cells =3D <0>;
	};

	memory@0 {
		device_type =3D "memory";
		reg =3D <0x0 0x9000000>;
	};
};

Let me know if you want the blob too (it's ~10k)

johannes

--=-Kbm+XYQPW975nkUiPzNB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJIdJdSAAoJEKVg1VMiehFYuzgQAL2x/X/lHLg0cfYlElOl3VMI
BZ3kxvDKE/M1hw3ijVrwXFmpwHai6rcM23EBYPcR725EzBl+u2eNGDrvVq+A6v1X
KM985qvc8SZH8+SELgrgZtkPQQyvYFWZISRonOFYXW49ebhYJOiVEcezZvb/+Q6o
+dfVuvyO6NeuaJnYE3bOwR7gd0g1+yoj7a7X78B7aTJyqt522Yap/ofgBpw6dS/e
JRCgGz38On5UyHcpwCgU+oAG0n1EGBdKhsuTZpDDxbypPl2phD9/OMz7w0pruy4q
fuoq5kVWKhojkJ+qVeOUf8s4o0abbx73P7joUlWWtwjixqGV2Q4xzQigrFXqwtuV
bVT4GV/2g8GeqPWcT0EWppeFPuQT8JAYzMq/NDk074CnwnvbkSGvo0r4MBVpK1ON
P8x4AzwerSb7eMp4gCIUQ1UvGGxRpbf/SJNjMPx+m+0PaUQ/864/jruS4HTINXs/
CV0isr+lYvS3P1+iyEPLUctDFrBW5FWmV8/t+7AJCER9Euf84M/UJiy/lW/qo8oc
D9KYNIxVqHFn8gUhIJj+a3zaxiQUdm/OUeuevyo58FXrPUp1rgOsOGLMOgtiviHM
RMSdLXDvcnbZ+UD3n/TD7NAAKGItCAwrgc5FSEHzVSKom0YTz+1WAb64fYfWbi0D
Ic2OZuDmEuxBKZQoW786
=cI0l
-----END PGP SIGNATURE-----

--=-Kbm+XYQPW975nkUiPzNB--
