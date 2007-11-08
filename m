Return-Path: <SRS0=zNDV=QB=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 67641DDDFD
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 19:48:17 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/6] ibm_newemac: Fix ZMII refcounting bug
Date: Thu, 8 Nov 2007 09:43:22 +0100
References: <20071108080730.75261DDDFB@ozlabs.org>
In-Reply-To: <20071108080730.75261DDDFB@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711080943.23107.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 08 November 2007, Benjamin Herrenschmidt wrote:
> When using ZMII for MDIO only (such as 440GX with RGMII for data and ZMII
> for MDIO), the ZMII code would fail to properly refcount, thus triggering a
> BUG_ON().
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Stefan Roese <sr@denx.de>

Best regards,
Stefan
