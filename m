Return-Path: <SRS0=GNhQ=Q5=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 1484FDDF24
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 20:42:14 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 24/25] powerpc: Base support for 440SPe "Katmai" eval board
Date: Thu, 6 Dec 2007 10:42:11 +0100
References: <20071206080134.7DB7CDE155@ozlabs.org>
In-Reply-To: <20071206080134.7DB7CDE155@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712061042.11364.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 06 December 2007, Benjamin Herrenschmidt wrote:
> This adds base support for the Katmai board, including PCI-X and
> PCI-Express (but no RTC, nvram, etc... yet).
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Stefan Roese <sr@denx.de>

I'll send a patch with a Katmai defconfig file in a few minutes.

Best regards,
Stefan
