Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3CFC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 02:34:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1A92064D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 02:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Wc6FcGZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1A92064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DPCW4pgVzDqYJ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 13:34:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Wc6FcGZt";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DP8r4GsQzDqRx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 13:31:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="Wc6FcGZt"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43DP8r1jkwz9s47; Tue, 11 Dec 2018 13:31:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1544495516;
 bh=0I79HB28OFEhLNC2eCziVQulddpsw9SCz4tu2b1j3cQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Wc6FcGZtCXGzc93GqCJWof/I03694sLTcbDtQUZRSqqXhsedAGnlf2rgxJ8QBzOi2
 lEIC42yDJmh0Pxr9nn5GApitzc5RuV8/fTqWFuAwDuHBfdR0/j0rnyS9LQFF6A79oZ
 pACD6QRrz4N8hxPJsqUG1kIapApChLwxlyCuAaSU=
Date: Tue, 11 Dec 2018 13:31:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] PCI: Add no-D3 quirk for Mellanox ConnectX-[45]
Message-ID: <20181211023151.GH4261@umbus.fritz.box>
References: <20181206041951.22413-1-david@gibson.dropbear.id.au>
 <20181206064509.GM15544@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mVonZaCXjkyW6e25"
Content-Disposition: inline
In-Reply-To: <20181206064509.GM15544@mtr-leonro.mtl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sbest@redhat.com, saeedm@mellanox.com,
 alex.williamson@redhat.com, paulus@samba.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, ogerlitz@mellanox.com, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net, tariqt@mellanox.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--mVonZaCXjkyW6e25
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 08:45:09AM +0200, Leon Romanovsky wrote:
> On Thu, Dec 06, 2018 at 03:19:51PM +1100, David Gibson wrote:
> > Mellanox ConnectX-5 IB cards (MT27800) seem to cause a call trace when
> > unbound from their regular driver and attached to vfio-pci in order to =
pass
> > them through to a guest.
> >
> > This goes away if the disable_idle_d3 option is used, so it looks like a
> > problem with the hardware handling D3 state.  To fix that more permanen=
tly,
> > use a device quirk to disable D3 state for these devices.
> >
> > We do this by renaming the existing quirk_no_ata_d3() more generally and
> > attaching it to the ConnectX-[45] devices (0x15b3:0x1013).
> >
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  drivers/pci/quirks.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> >
>=20
> Hi David,
>=20
> Thank for your patch,
>=20
> I would like to reproduce the calltrace before moving forward,
> but have trouble to reproduce the original issue.
>=20
> I'm working with vfio-pci and CX-4/5 cards on daily basis,
> tried manually enter into D3 state now, and it worked for me.
>=20
> Can you please post your full calltrace, and "lspci -s PCI_ID -vv"
> output?

Sorry, I may have jumped the gun on this.  Using disable_idle_d3 seems
to do _something_ for these cards, but there are some other things
going wrong which are confusing the issue.  This is on POWER, which
might affect the situation.  I'll get back to you once I have some
more information.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mVonZaCXjkyW6e25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwPIZQACgkQbDjKyiDZ
s5IBRRAA2MqVAFyjHwo1FjE4IFA/HwOxHbo9qSkEOrFE10oGylCi9LVKhKeZ0RV4
c6IrjliPYwy9Uy/B8fp+mCH1UeE73vSp+ieEqZ7TgMf1HqsO6vyYUcCO+JpcX1Ko
9fiyQMCuEfvF3Z6A+XXzZ6Jp5MuGTF496Xv5n8j9672DAo6I1iFf75ayhORZcUVh
ZrLGtGa7k88Mhizbk2ZV9TFUPWcYV1ekfWY/Wvdq59E2b7fNhyPQiNop2cbEIt4K
BxD6MxGig0C+puFptKwdDNPMQB/nRNc843FtQ4JKUsKcSt3N0Wk7SHdINn6Kxjub
fINnCEUAjTNOxyOU3lWgBc2BrI6xRpyYodMDlIzWQwM4/Kss40Qzg2zUWcpEkxIi
KPpehbo/gMcj1SGZNJYV7NE1tuF+Z+kdfcN+ZM/D8sFTwWtMjKyiziDHXBgsc8WD
wpH0wLZkqnPnluipNRaq2foShsiDTX5OLWR4tjmmcrIcF7BppMKz7/HIlaUXAqZ7
6ViQMDhThPBU0CetZx9esXVW/PI+XPclAgFj6fRrKnVtDYQIkUO8NolTeYQjCWZA
4wsPm9PX1a4/XxEVYn15PU2wADgdsRgkRRXtddl8/nmWsrY/0U2igsTWLuKF9ugW
0V8raqIYkzdiHenfBMlsIod3G/xTBx+rMKbktPvefCIMlKNTcGE=
=i2A1
-----END PGP SIGNATURE-----

--mVonZaCXjkyW6e25--
