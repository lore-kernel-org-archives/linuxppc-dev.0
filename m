Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 3F7511007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Dec 2010 07:48:49 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/2][v4] fsl_rio: move machine_check handler into
	machine_check_e500 & machine_check_e500mc
Date: Tue, 30 Nov 2010 12:47:17 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552015F5E3B@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <1290063452-20873-1-git-send-email-b21989@freescale.com>
References: <1290063452-20873-1-git-send-email-b21989@freescale.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Shaohui Xie" <b21989@freescale.com>, <linuxppc-dev@lists.ozlabs.org>
Cc: akpm@linux-foundation.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tested on my 8548/RIO setup - works as expected.

Alex.

> -----Original Message-----
> From: Shaohui Xie [mailto:b21989@freescale.com]
> Sent: Thursday, November 18, 2010 1:58 AM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: akpm@linux-foundation.org; Shaohui Xie; Li Yang; Kumar Gala; Roy
Zang; Bounine, Alexandre
> Subject: [PATCH 1/2][v4] fsl_rio: move machine_check handler into
machine_check_e500 &
> machine_check_e500mc
>=20
