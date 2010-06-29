Return-Path: <sfr@canb.auug.org.au>
Date: Tue, 29 Jun 2010 16:02:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Using devices trees on X86
Message-Id: <20100629160251.9e9fe7b1.sfr@canb.auug.org.au>
In-Reply-To: <AANLkTikEJluwUSTmG64jgQYAt_8YI7-gVA2iqOPKrM9W@mail.gmail.com>
References: <0bcc23b9-2cbd-4465-b17c-7b3c2dff9fd3@VA3EHSMHS007.ehs.local>
	<20100629123843.5f94d477.sfr@canb.auug.org.au>
	<AANLkTikEJluwUSTmG64jgQYAt_8YI7-gVA2iqOPKrM9W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__29_Jun_2010_16_02_51_+1000_3zaId60c1ZdQbS8+"
Cc: Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au,
	David Miller <davem@davemloft.net>,
	Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__29_Jun_2010_16_02_51_+1000_3zaId60c1ZdQbS8+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

On Mon, 28 Jun 2010 22:56:14 -0700 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> I've got an Ack from David now.  I'll wait for more acks, and then
> pull the whole series of 5 into my devicetree-next branch.  It's
> certainly less invasive that some of the other changes arch changes
> I've taken through my tree.

Yes, certainly.  However, I have a plan to write a series of patches for
PowerPC that may clash some what, so if that is the case, I might ask Ben
to take the one patch as well.  Especially if the conflict turns up in
linux-next :-)

Thanks.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__29_Jun_2010_16_02_51_+1000_3zaId60c1ZdQbS8+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMKYyLAAoJEDMEi1NhKgbsrngH/0mqEE+cpwI9SPgN/f8ekHrL
10rb3vBkMyKQngvGYKusBlKwj5mW4L7HkhvHvv9EqZGBA2jwxqtPYC09tywCe3Ie
hgwa7UIneoIZApeibMQKWItW7b/UJWOHyRmumFa5ixJ9J/SkP6QidygkaSwZGJbF
nwEY623fYJtyRcjQaYKiwqsbkV8olkkHNXKKK9Yx+Qu4O+Zywn1ljGaDVVgB/Y0+
OF9Xd1FzF5m99S17qYfU0d1ggdk8ygGWYa2rB8DxkNGreUL2nkmukk6VC54mqIuc
LYYxegVyIXfg55OEo6H7j07zrAYuAs+JzDg0rCks8g3V12duBwyyBCKe9/tgZ1s=
=hiZm
-----END PGP SIGNATURE-----

--Signature=_Tue__29_Jun_2010_16_02_51_+1000_3zaId60c1ZdQbS8+--
