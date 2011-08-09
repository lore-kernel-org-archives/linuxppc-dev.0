Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id CA9CEB6F67
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Aug 2011 22:48:19 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] rio: Use discovered bit to test if enumeration is complete
Date: Tue, 9 Aug 2011 05:36:06 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552020244E5@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <1312856226-3695-1-git-send-email-b34182@freescale.com>
References: <1312856226-3695-1-git-send-email-b34182@freescale.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Liu Gang" <b34182@freescale.com>, <linux-kernel@vger.kernel.org>
Cc: r58472@freescale.com, r61911@freescale.com, linuxppc-dev@ozlabs.org,
	Liu Gang <Gang.Liu@freescale.com>, B11780@freescale.com,
	akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, August 08, 2011 at 10:17 PM, Liu Gang wrote:
> Subject: [PATCH] rio: Use discovered bit to test if enumeration is
> complete
>=20
> The discovered bit in PGCCSR register indicates if the device has
> been discovered by system host. In Rapidio system, some agent devices
> can also be master devices. They can issue requests into the system.
>=20
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> ---
>  drivers/rapidio/rio-scan.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Alexandre Bounine <alexandre.bounine@idt.com>
