Return-Path: <Kari.Davidsson@marel.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E9C6CB7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jul 2009 03:51:06 +1000 (EST)
Received: from mail.marel.is (mail.marel.is [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id 2A4FDDDD0C
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Jul 2009 03:51:04 +1000 (EST)
Message-ID: <4A523984.2080904@marel.com>
Date: Mon, 6 Jul 2009 17:51:00 +0000
From: =?ISO-8859-1?Q?K=E1ri_Dav=ED=F0sson?= <kari.davidsson@marel.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: dma_ops->map_page == NULL
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I am doing a driver that uses dma_map_single().

After changing to to linux 2.6.29.3 I am getting
segfaults in dma_map_single() because dma_ops->map_page is NULL.
Actually dma_ops looks funky too.

The driver is an of_platform_driver which is declared as an child of
the lbp (fsl,lpb) node of the device tree.

This is on powerpc 5200b platform.

rg
kd
