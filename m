Return-Path: <kumar.gala@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 728A1B70D4
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 01:44:58 +1100 (EST)
Received: from mail127-tx2 (localhost.localdomain [127.0.0.1])	by
	mail127-tx2-R.bigfish.com (Postfix) with ESMTP id 5281817604E1	for
	<linuxppc-dev@ozlabs.org>; Wed, 13 Oct 2010 14:44:54 +0000 (UTC)
Received: from TX2EHSMHS038.bigfish.com (unknown [10.9.14.252])	by
	mail127-tx2.bigfish.com (Postfix) with ESMTP id 33B801A90056	for
	<linuxppc-dev@ozlabs.org>; Wed, 13 Oct 2010 14:44:54 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o9DEibKs022647	for <linuxppc-dev@ozlabs.org>;
	Wed, 13 Oct 2010 07:44:37 -0700 (MST)
Subject: Re: [PATCH 1/2] [v2] powerpc/85xx: add ngPIXIS FPGA device tree node
	to the P1022DS board
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1286480203-28227-1-git-send-email-timur@freescale.com>
Date: Wed, 13 Oct 2010 09:44:36 -0500
Message-ID: <63394809-3C2C-40BC-9ACA-BAA5A76C638E@freescale.com>
References: <1286480203-28227-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 7, 2010, at 2:36 PM, Timur Tabi wrote:

> The device tree for Freescale's P1022DS reference board is missing the node
> for the ngPIXIS FPGA.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/boot/dts/p1022ds.dts |   11 +++++++++++
> 1 files changed, 11 insertions(+), 0 deletions(-)

applied

- k
