Return-Path: <marcelo.cerri@canonical.com>
Received: from mail-vk0-x22e.google.com (mail-vk0-x22e.google.com
 [IPv6:2607:f8b0:400c:c05::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spHjc3PvLzDrFn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 23:07:46 +1100 (AEDT)
Received: by mail-vk0-x22e.google.com with SMTP id 192so187464863vkl.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Oct 2016 05:07:46 -0700 (PDT)
Date: Tue, 4 Oct 2016 09:07:37 -0300
From: Marcelo Cerri <marcelo.cerri@canonical.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, George Wilson <gcwilson@us.ibm.com>,
 Claudio Carvalho <cclaudio@br.ibm.com>,
 Paulo Flabiano Smorigo <pfsmorigo@br.ibm.com>,
 joy.latten@canonical.com, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] crypto: sha1-powerpc: little-endian support
Message-ID: <20161004120737.GA16223@gallifrey>
References: <1474659116-4689-1-git-send-email-marcelo.cerri@canonical.com>
 <20160928131551.GA31082@gallifrey>
 <20160928132015.GA21312@gondor.apana.org.au>
 <20160928132718.GB31082@gallifrey>
 <87pong4oq3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
In-Reply-To: <87pong4oq3.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Ubuntu, CRYPTO_MANAGER_DISABLE_TESTS is set by default. So I had to
disable this config in order to make sha1-powerpc fail in the crypto API
tests. However, even with tests disabled, any usage of sha1-powerpc
should result in incorrect results.

--=20
Regards,
Marcelo

On Tue, Oct 04, 2016 at 05:23:16PM +1100, Michael Ellerman wrote:
> Marcelo Cerri <marcelo.cerri@canonical.com> writes:
>=20
> > [ Unknown signature status ]
> > On Wed, Sep 28, 2016 at 09:20:15PM +0800, Herbert Xu wrote:
> >> On Wed, Sep 28, 2016 at 10:15:51AM -0300, Marcelo Cerri wrote:
> >> > Hi Herbert,
> >> >=20
> >> > Any thoughts on this one?
> >>=20
> >> Can this patch wait until the next merge window? On the broken
> >> platforms it should just fail the self-test, right?
> >
> > Yes. It fails on any LE platform (including Ubuntu and RHEL 7.1).
>=20
> How are you testing this? I thought I was running the crypto tests but
> I've never seen this fail.
>=20
> cheers

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJX85uIAAoJEM8aS8c01e1HPcEH/1tDwYlq2+4dg+EF4M384b0B
Q5pPKS74g/5abaoCpxgBflHVvg6nr4XgWgrRIECHqiMBKJWN7rUZ7XigtPnNtq4a
vKAVUP6lYDem1cB1i1p9g1maAAyOYn5LCfETfIqqM3n9qL5Valje8krc8buxVI7R
q0XGMRBSmmqTyk7gW/VDfoZy5TMlfflKYq1E1bPBEEIhMEQFuQS6b9cniThryh0l
WMOKv/mNctP5a9trB/BGceluuhtcoeTBhdFhDEyHNOPvsGsdOL7IDSlGRZcQAxaS
pw8dM465K2JA1y8ZdWqsTSb4UHuhZ+gO/BBNwg+nJjWo5MjXSni3PO0mUM1hzXw=
=Gkyv
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
