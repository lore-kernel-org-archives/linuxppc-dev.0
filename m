Return-Path: <SRS0=zNDV=QB=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 09B5EDDE01
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 20:38:44 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 6/6] ibm_newemac: Cleanup/fix support for STACR register
	variants
Date: Thu, 8 Nov 2007 10:38:58 +0100
References: <20071108080733.06584DDEA0@ozlabs.org>
In-Reply-To: <20071108080733.06584DDEA0@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711081038.59184.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 08 November 2007, Benjamin Herrenschmidt wrote:
> There are a few variants of the STACR register that affect more than
> just the "AXON" version of EMAC. Replace the current test of various
> chip models with tests for generic properties in the device-tree.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Stefan Roese <sr@denx.de>

Best regards,
Stefan
