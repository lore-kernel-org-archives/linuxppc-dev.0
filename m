Return-Path: <B11780@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 52B71B6FD7
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2011 03:19:06 +1100 (EST)
Received: from mail163-tx2 (localhost.localdomain [127.0.0.1])	by
	mail163-tx2-R.bigfish.com (Postfix) with ESMTP id 967849D8383	for
	<linuxppc-dev@ozlabs.org>; Tue, 15 Mar 2011 16:19:02 +0000 (UTC)
Received: from TX2EHSMHS047.bigfish.com (unknown [10.9.14.250])	by
	mail163-tx2.bigfish.com (Postfix) with ESMTP id D6DA5CC00D0	for
	<linuxppc-dev@ozlabs.org>; Tue, 15 Mar 2011 16:17:50 +0000 (UTC)
Received: from udp114135uds.am.freescale.net (udp114135uds.am.freescale.net
	[10.82.243.198])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP
	id p2FGHhHT007947	for <linuxppc-dev@ozlabs.org>;
	Tue, 15 Mar 2011 11:17:43 -0500 (CDT)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0 (Apple Message framework v1082)
Subject: Re: [PATCH 1/3] powerpc/fsl: 85xx: document cache sram bindings
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1260257477-21942-1-git-send-email-vivek.mahajan@freescale.com>
Date: Tue, 15 Mar 2011 11:17:42 -0500
Message-ID: <9C374EBA-A972-4DD1-AD61-DA8440EC6FB4@freescale.com>
References: <1260257477-21942-1-git-send-email-vivek.mahajan@freescale.com>
To: Linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 8, 2009, at 1:31 AM, Vivek Mahajan wrote:

> Adds binding documentation for cache sram for the PQ3 and
> some QorIQ based platforms.
>=20
> Signed-off-by: Vivek Mahajan <vivek.mahajan@freescale.com>
> ---
> .../powerpc/dts-bindings/fsl/85xx_cache_sram.txt   |   20 =
++++++++++++++++++++
> 1 files changed, 20 insertions(+), 0 deletions(-)
> create mode 100644 =
Documentation/powerpc/dts-bindings/fsl/85xx_cache_sram.txt

applied

- k=
