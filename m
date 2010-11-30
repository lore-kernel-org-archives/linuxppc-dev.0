Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 321B41007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Dec 2010 07:49:44 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/2][v3] rapidio,
	powerpc/85xx: Error interrupt handler for sRIO.
Date: Tue, 30 Nov 2010 12:48:53 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552015F5E40@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <1290063473-20950-1-git-send-email-b21989@freescale.com>
References: <1290063473-20950-1-git-send-email-b21989@freescale.com>
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

Applies correctly now. Lab tested on 8548/RIO setup.

Alex.=20

> -----Original Message-----
> From: Shaohui Xie [mailto:b21989@freescale.com]
> Sent: Thursday, November 18, 2010 1:58 AM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: akpm@linux-foundation.org; Shaohui Xie; Li Yang; Kumar Gala; Roy
Zang; Bounine, Alexandre
> Subject: [PATCH 2/2][v3] rapidio, powerpc/85xx: Error interrupt
handler for sRIO.
>=20
> The sRIO controller reports errors to the core with one signal, it
uses
> register EPWISR to provides the core quick access to where the error
occurred.
> The EPWISR indicates that there are 4 interrupts sources, port1,
port2, message
> unit and port write receive, but the sRIO driver does not support
port2
> for now, still the handler takes care of port2.
> Currently the handler only clear error status without any recovery.
