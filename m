Return-Path: <B11780@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C4F3DB6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 23:55:02 +1000 (EST)
Subject: Re: [PATCH 2/2][v3] rapidio,
	powerpc/85xx: Error interrupt handler for sRIO.
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1290063473-20950-1-git-send-email-b21989@freescale.com>
Date: Fri, 20 May 2011 08:53:18 -0500
Message-ID: <341CA772-7912-40D4-B340-A83FDFD6E17B@freescale.com>
References: <1290063473-20950-1-git-send-email-b21989@freescale.com>
To: Shaohui Xie <b21989@freescale.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 18, 2010, at 12:57 AM, Shaohui Xie wrote:

> The sRIO controller reports errors to the core with one signal, it =
uses
> register EPWISR to provides the core quick access to where the error =
occurred.
> The EPWISR indicates that there are 4 interrupts sources, port1, =
port2, message
> unit and port write receive, but the sRIO driver does not support =
port2
> for now, still the handler takes care of port2.
> Currently the handler only clear error status without any recovery.
>=20
> Signed-off-by: Shaohui Xie <b21989@freescale.com>
> Cc: Li Yang <leoli@freescale.com>
> Cc: Kumar Gala <kumar.gala@freescale.com>
> Cc: Roy Zang <tie-fei.zang@freescale.com>
> Cc: Alexandre Bounine <alexandre.bounine@idt.com>
> ---
> updated to 37-rc2
> arch/powerpc/sysdev/fsl_rio.c |   85 =
+++++++++++++++++++++++++++++++++++++----
> 1 files changed, 77 insertions(+), 8 deletions(-)

applied to merge

- k=
