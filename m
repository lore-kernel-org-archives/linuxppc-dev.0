Return-Path: <sfr@canb.auug.org.au>
Date: Fri, 7 Feb 2014 09:25:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] tree-wide: clean up no longer required #include
 <linux/init.h>
Message-Id: <20140207092505.4c42d130faff151659a908f9@canb.auug.org.au>
In-Reply-To: <1391547118-21967-1-git-send-email-paul.gortmaker@windriver.com>
References: <1391547118-21967-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__7_Feb_2014_09_25_05_+1100_5G4DE1j7Qv3c23/u"
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
 linux-m68k@vger.kernel.org, rusty@rustcorp.com.au, linux-ia64@vger.kernel.org,
 kvm@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 x86@kernel.org, gregkh@linuxfoundation.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>, linux-alpha@vger.kernel.org,
 sparclinux@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__7_Feb_2014_09_25_05_+1100_5G4DE1j7Qv3c23/u
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Tue, 4 Feb 2014 15:51:58 -0500 Paul Gortmaker <paul.gortmaker@windriver.=
com> wrote:
>
> We've had this in linux-next for 2+ weeks (thanks Stephen!) as a
> linux-stable like queue of patches, and as can be seen here:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/paulg/init.git
>=20
> most of the changes in the last week have been trivial adding acks
> or dropping patches that maintainers decided to take themselves.

Any thoughts on merging this?  I can feel it bitrotting :-(

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Fri__7_Feb_2014_09_25_05_+1100_5G4DE1j7Qv3c23/u
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS9AvOAAoJEMDTa8Ir7ZwVgtAP/0JLUjtgIOoRu0wcAutXabJX
FYj8RB3kSvX1YCe+fyEXCiHYTCnMnoLSrGWNqRjga5M/zdrw7P0v+E4MDv+ZLME6
n4njMVl56NGUE0ULzj09ZwV0oANJ0u34mkTpzUs3SmQkuoi3XnseaoLgL3hBavOY
QAq/OK/J90jBjm3h9JjAEGDBdcFEgY5qsiQJNU2o47QRfX+/VWsGT3WwQs2Iy5Ih
YNzju/qmBczjlTJouCfrXBKeOG48uMgtalV9hLiaTxubLQRSjJ0Gy7h4runSPJ6Z
sqvFMePFjfBD0WSZ/WB50ArXxpeR2YR1qWw0BDFAKr8NXvR2Zb7a0nIkdOIs5Zep
BRjtC0xMJfTW9GG2g220PyrsYchl2WW31AC9VhjGXk8/d2Gk5A1XfO1lrVohTTMs
bZyk3rIpXrRTdzTqAmVI+6gsZ+Xd1B9gTGmlvw89CFZz5K/5AvdzkmuD/3AI/yv9
XFJi5zBOAhbw2D+u3EqqMCV+arE4mxQVPXOjiI2hakGy5NvANrLZHd136aCA/rjH
Iv4WGKgGQ2rf/GykI1T5vmlRf5k2RLrxG3MPYqS+0IL9OY9S3iswDib+jnRpWjN5
e1r23hmT1lrb2N7Q4+pzRpX4GRnP5hiAHGFfgijXiPlz/PXj9oqmvIreOtc4jCX6
gqAy38tkyQhHVjVxOgF9
=rXtU
-----END PGP SIGNATURE-----

--Signature=_Fri__7_Feb_2014_09_25_05_+1100_5G4DE1j7Qv3c23/u--
