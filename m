Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD75C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 08:02:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B502146D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 08:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJLScHgL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B502146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439Sjw3qCKzDr6v
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 19:01:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OJLScHgL";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=leon@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="OJLScHgL"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439R1T1VXtzDr2s
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 17:45:16 +1100 (AEDT)
Received: from localhost (unknown [77.138.135.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3EB3220989;
 Thu,  6 Dec 2018 06:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544078714;
 bh=g6Czx7nLEy93+bDguAtYiatB9x3PPOqHGI/j5b57/Ak=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OJLScHgLgDQ1JZdxw2PmXeliVG9qLciE4iGyalPGKT+MNhI93eh5pXXbcuP2axMx2
 ccmKIP3uIzsXH0/L7Q5FdKTNj8uMco4eTGSAqj5/S+b7z7HeKBOTvLQae1yJ13vM4w
 Jv1XIReSKLcBBTG4dxsiL7CsUOxuhY/+G4wjWdyw=
Date: Thu, 6 Dec 2018 08:45:09 +0200
From: Leon Romanovsky <leon@kernel.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] PCI: Add no-D3 quirk for Mellanox ConnectX-[45]
Message-ID: <20181206064509.GM15544@mtr-leonro.mtl.com>
References: <20181206041951.22413-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Re2uCLPLNzqOLVJA"
Content-Disposition: inline
In-Reply-To: <20181206041951.22413-1-david@gibson.dropbear.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Thu, 06 Dec 2018 18:59:34 +1100
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


--Re2uCLPLNzqOLVJA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 06, 2018 at 03:19:51PM +1100, David Gibson wrote:
> Mellanox ConnectX-5 IB cards (MT27800) seem to cause a call trace when
> unbound from their regular driver and attached to vfio-pci in order to pass
> them through to a guest.
>
> This goes away if the disable_idle_d3 option is used, so it looks like a
> problem with the hardware handling D3 state.  To fix that more permanently,
> use a device quirk to disable D3 state for these devices.
>
> We do this by renaming the existing quirk_no_ata_d3() more generally and
> attaching it to the ConnectX-[45] devices (0x15b3:0x1013).
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  drivers/pci/quirks.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>

Hi David,

Thank for your patch,

I would like to reproduce the calltrace before moving forward,
but have trouble to reproduce the original issue.

I'm working with vfio-pci and CX-4/5 cards on daily basis,
tried manually enter into D3 state now, and it worked for me.

Can you please post your full calltrace, and "lspci -s PCI_ID -vv"
output?

Thanks

--Re2uCLPLNzqOLVJA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcCMV1AAoJEORje4g2clinjAQP/1QohDmpz3Nx1/0h9KEad/Gv
xb/XKSpynLFHroGdEEAHUaDgLOfsp5WoJxVs5sj8/EI7ZB7+jT89DAByeXkFQI5J
8LBm+eEZboNTLa2lOcl5yBSVNWb3POGFmsuTAf2q4F+fijds+lyATk3kKYpDc7wC
4zJ22LiEr4rryTOuxZyFi5YTaNso3WhHs0XB8bAFoJar9ypY+aSPq48C+wU+08da
AbD3yThzPT++z61FgK5tmyaG2xN8uZmHzeRpSaX7vEDMgPznJk4qnIaA0FtCnjRu
SYOg8XLPksqmrdU/N/vV5FM2uk77s8yoNtOEkdCg19rkG04c2pzqdX/aZtW4epKX
h1mKWK2x21U2+l/gd5atRuFuJfP3k7P6LEsfzWprmFsyC6fwrt2H8ojN+10fuEiP
1KURSsGdMYCrKrDklpsAeu5JHRc5UEOKyQsWPQZ+wmZtpI4zJTW9Av9YfYd/RZ6d
PefEN2j6gmDpC7ffZqV0oenEuEgGAPGFiBRRTeOqgggfLMT1Rn9FZHX4zAGLZMpR
jciOwJNwN9rPTkLyEyCQItjhqQjty3gvDMlYpuMpNsYIXcyl/gkjMWuke4TaHHZP
M6g+P6qfUvDEDTlMO+wU6hcKRmqLFr+LsjQhtfHza9j1gGIcYO6FFTvPN0o0tGcq
mItAd9DzgosnlmUT2DHQ
=Hvye
-----END PGP SIGNATURE-----

--Re2uCLPLNzqOLVJA--
