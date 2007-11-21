Return-Path: <SRS0=WtMl=QO=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 5CABDDDDFD
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 18:18:42 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 8/8] ibm_newemac: Skip EMACs that are marked unused by the
	firmware
Date: Wed, 21 Nov 2007 08:13:51 +0100
References: <20071121060737.6AA72DDE0C@ozlabs.org>
In-Reply-To: <20071121060737.6AA72DDE0C@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711210813.51525.sr@denx.de>
Cc: jgarzik@pobox.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 21 November 2007, Benjamin Herrenschmidt wrote:
> From: Hugh Blemings <hugh@blemings.org>
>
> Depending on how the 44x processors are wired, some EMAC cells
> might not be useable (and not connected to a PHY). However, some
> device-trees may choose to still expose them (since their registers
> are present in the MMIO space) but with an "unused" property in them.
>
> Signed-off-by: Hugh Blemings <hugh@blemings.org>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Stefan Roese <sr@denx.de>

Best regards,
Stefan
