Return-Path: <B29983@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 412591007D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2012 18:23:41 +1100 (EST)
From: Tang Yuantian-B29983 <B29983@freescale.com>
To: Bob Cochran <ppc@mindchasers.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Jin Qing <b24347@freescale.com>
Subject: RE: [PATCH 1/2 V3] powerpc/85xx: Add P1024rdb dts support
Date: Tue, 14 Feb 2012 07:23:33 +0000
Message-ID: <D07C73A334FF604B95B3CBD2A545D07B050656@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1328860851-392-1-git-send-email-b29983@freescale.com>
 <4F3869F8.6080802@mindchasers.com>
In-Reply-To: <4F3869F8.6080802@mindchasers.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> I'm curious how fsl_pq_mdio_probe returns successfully when probing the
> phys on the first pass (mdio@24000).  I don't have a P1024 to test with,
> but I believe it has the same ETSEC configuration as the P1010 that I
> work with.
>=20
> Inside the fsl_pq_mdio_probe routine (fsl_pq_mdio.c), a successful search
> of a tbi child node is required with a tbi->type of "tby-phy".
> If it doesn't find this node, the probe routine will return an error of
> EBUSY.  The logic from the routine is provided below:
>=20

It is right if you work on kernel 3.3 or later version.
Probably the .probe function needs to be modified, not this dts.
I am working on it and resend this patch, if needed.

Regards,
Yuantian
