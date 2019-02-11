Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D5FC169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 23:33:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81975214DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 23:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81975214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43z2CY3jFnzDqWS
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 10:33:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=dgibson@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43z29s2WPMzDqSq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 10:31:41 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7C1818E581;
 Mon, 11 Feb 2019 23:31:38 +0000 (UTC)
Received: from umbus.fritz.box (vpn2-54-20.bne.redhat.com [10.64.54.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2646C62662;
 Mon, 11 Feb 2019 23:31:35 +0000 (UTC)
Date: Tue, 12 Feb 2019 10:31:29 +1100
From: David Gibson <dgibson@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] powerpc/configs: Enable CONFIG_USB_XHCI_HCD by default
Message-ID: <20190212103129.19de0cfc@umbus.fritz.box>
In-Reply-To: <1549885032-15702-1-git-send-email-thuth@redhat.com>
References: <1549885032-15702-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/oZceLsJMnSukU+6Pd+OBIJW"; protocol="application/pgp-signature"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 11 Feb 2019 23:31:39 +0000 (UTC)
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
Cc: Laurent Vivier <lvivier@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/oZceLsJMnSukU+6Pd+OBIJW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Feb 2019 12:37:12 +0100
Thomas Huth <thuth@redhat.com> wrote:

> Recent versions of QEMU provide a XHCI device by default these
> days instead of an old-fashioned OHCI device:
>=20
>  https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D57040d451315320b7d=
27
>=20
> So to get the keyboard working in the graphical console there again,
> we should now include XHCI support in the kernel by default, too.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Wow, we didn't before?  That's bonkers.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/configs/pseries_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/config=
s/pseries_defconfig
> index ea79c51..62e12f6 100644
> --- a/arch/powerpc/configs/pseries_defconfig
> +++ b/arch/powerpc/configs/pseries_defconfig
> @@ -217,6 +217,7 @@ CONFIG_USB_MON=3Dm
>  CONFIG_USB_EHCI_HCD=3Dy
>  # CONFIG_USB_EHCI_HCD_PPC_OF is not set
>  CONFIG_USB_OHCI_HCD=3Dy
> +CONFIG_USB_XHCI_HCD=3Dy
>  CONFIG_USB_STORAGE=3Dm
>  CONFIG_NEW_LEDS=3Dy
>  CONFIG_LEDS_CLASS=3Dm
> --=20
> 1.8.3.1
>=20


--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/oZceLsJMnSukU+6Pd+OBIJW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxiBdEACgkQbDjKyiDZ
s5JXvw//YDOdFzF5NRgMIv5qLkrRpE9dTblN5oLmx2DSLsC3OsRPdn4BdpNjCdNw
0rEFuc1PRyaPdZ71ob4JM+d15kaSQdtdseNqRxHOCvb9WQfy/CHjfosH43rSBU1h
aJliHVJwZqKqTuQfqZGy5gmtq6z0VRLiWTrPjQhsqkZ9QPqc3HSm6a5Hk2tOBu2I
kdrADZUe5dg/mDVSZd6tWQEmbK5o53UHnqPL2uEa26I1/v4eQOYv4UYQS71gX7G6
4IC00XNHNDgF0BTT98gnTB1W0AF15eTVWe2nS4wNwurxdpv3a2jSumLSnoqElawZ
1VI7QFk3paT5dNgvFacLABbVL/Mo5QHiPxV5fMQonY1ZxJa1aYExSyCsLPH5zKY2
Xjoo/ZvbITici2BOnwatHXNmkPop1euSsyZKHF3QtCK4oVZrR0geFmAwQ9/JOEOj
RdHcGEOumM4POIH/bAlC+4tCh9XKYi2lrQAYZscgsW8LXjxYsUmymfmws3IMO5dl
19tEh5vRXyN2cdcRBXj3cMrcENGbvCrPA30KSB5ecRwrPGlPDFOqdmz40gaH+yvs
jB0pABx2U1MayIjRoWrniyJjjfEYD54Z7mwV7Mcjh6KUNQlFd+v9xHWeT9c5naOE
Iw3GsutHzWI1zq+uQZH2dVVPrCf0RLynrXNkVHsBeb7nHjy14XU=
=NLaV
-----END PGP SIGNATURE-----

--Sig_/oZceLsJMnSukU+6Pd+OBIJW--
