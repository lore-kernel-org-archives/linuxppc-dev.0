Return-Path: <michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: Re: i2c-bus@0 twice?
Date: Fri, 17 Mar 2006 09:53:22 +1100
References: <1142447397.4670.12.camel@localhost>
In-Reply-To: <1142447397.4670.12.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1700403.DoaiLJgz5T";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200603170953.25209.michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1700403.DoaiLJgz5T
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, 16 Mar 2006 05:29, Johannes Berg wrote:
> johannes@quad:/proc/device-tree/ht@0,f2000000/pci@8/mac-io@7/i2c@18000$ ls
> AAPL,address       built-in     i2c-bus@0         linux,phandle
> AAPL,address-step  compatible   interrupt-parent  name
> AAPL,i2c-rate      device_type  interrupts        reg
> #address-cells     i2c-bus@0    linux,device      #size-cells
>
> Somewhat odd that i2c-bus@0 exists twice :) Anyone have an explanation?

Do you see it twice in OF also?

cheers

=2D-=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--nextPart1700403.DoaiLJgz5T
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEGexldSjSd0sB4dIRAj90AKCAn5rFdMNtJ9CZrRi3n4ARIflCaACgwwvV
rx/6nMpHGgVmGf5/kugKgO8=
=3ZSZ
-----END PGP SIGNATURE-----

--nextPart1700403.DoaiLJgz5T--
