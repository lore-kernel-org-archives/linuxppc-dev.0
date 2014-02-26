Return-Path: <tony@bakeyournoodle.com>
Date: Thu, 27 Feb 2014 10:19:53 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: ftrace: bugfix for test_24bit_addr
Message-ID: <20140226231953.GA16575@thor.bakeyournoodle.com>
References: <1393381381-30179-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <20140226043552.GA14672@in.ibm.com>
 <1393417336.17341.0.camel@concordia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
In-Reply-To: <1393417336.17341.0.camel@concordia>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Liu Ping Fan <kernelfans@gmail.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2014 at 11:22:16PM +1100, Michael Ellerman wrote:
=20
> ppc_function_entry() just needs to be a nop on LE, as it already is on 32=
-bit.

Well on LE ABI2, but yes.

Yours Tony

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJTDnaZAAoJEPvNNsFAAoTB4NoP/i6zID8zZ9KmHHh6s52Sj80R
5rZeDBaqrAx/821oODvAvoujRNOw4F5Rnyp4JXD0Uka4xVxI5v0L/ZUqpANKpqGw
iTm43d+Hlvlttqp8I25NNhcg9444jmCiSfS7yLZYpsENZBf8XJMvHV9QujDj0NVE
4rL2SFbfQclu5CFFbh6yXLwx4uSqsdKcCmzmkBb8pjY984uz2lYUK4+pnYLx2dZ9
65eUFV09iSPSbrGUp9cPm4O8AMWM9yo6nNPh/w/sYmtktvoXlsAKbjnp+dKqWGTU
KCD3JNuKXsXNZqRsl7P8QwNh7dHf/+tP5w3ZHM8KsSHufB74E1I/ESBLtWZVmFol
jXtC9vLCKQc4T0kopqhbGsM5ftUxC9ujwsvfpsCYakYBJ10CShjNhJVJxg6oTywc
4lAUQK5Z7QnyfhQIhfoBVmg4KCsxuqk3+4W25vXrXgSl43MxR0wwjB2M9M7vgRgQ
VYgEWS8Frh+Gfu+kdBQKgMBxLrWUpsfogWa4XXfDHkqZtQMjGH7/RYH80Mqz1ryi
wFPaszBW5VeLcabTETuAiJBHUZVedKA1Jx0YmrdBeNFGhxLZ5Ym6CSX1UCeMjq0E
kDEhNG5SgCRNEZGfn178DLHp4+mMhR786BVrlD80jXMnMsJUFchpXs3hJ+zki62W
rmaI/pKXKmmthtVIMriE
=QeMW
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
