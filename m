Return-Path: <daniel.schnell@marel.com>
Received: from mail.marel.com (mail.marel.com [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id A4A73DDF0D
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 01:52:20 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH]: [MPC5200] (v2) Add ATA DMA support
Date: Mon, 30 Jun 2008 15:40:08 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB03102DE8@is-hdq-exchange.marel.net>
In-Reply-To: <792f5f410806270544p69c773b9o9df4a5618d4babe1@mail.gmail.com>
References: <792f5f410806270544p69c773b9o9df4a5618d4babe1@mail.gmail.com>
From: "Daniel Schnell" <daniel.schnell@marel.com>
To: "Tim Yamin" <plasm@roo.me.uk>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Against which kernel is this patch against ?



Regards,

Daniel.


Tim Yamin wrote:
> Changes from previous version:
>=20
> - Add FIFO status error checking code before a DMA transaction starts
> and after it is completed.=20
> - Fix an incorrect check in the previous patch causing spurious "dma
> table too small" errors.=20
>=20
> Tim
