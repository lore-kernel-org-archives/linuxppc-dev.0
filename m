Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 0D33DDE24C
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 01:36:50 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Grant Erickson <gerickson@nuovations.com>
Subject: Re: [PATCH v2] ibm_newemac: Add MII mode support to the EMAC RGMII
	bridge.
Date: Tue, 8 Jul 2008 17:35:08 +0200
References: <C497F939.104DB%gerickson@nuovations.com>
	<1215529386-12749-1-git-send-email-gerickson@nuovations.com>
In-Reply-To: <1215529386-12749-1-git-send-email-gerickson@nuovations.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200807081735.08671.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 08 July 2008, Grant Erickson wrote:
> This patch adds support to the RGMII handler in the EMAC driver for
> the MII PHY mode such that device tree entries of the form `phy-mode =
> "mii";' are recognized and handled appropriately.
>
> While logically, in software, "gmii" and "mii" modes are the same,
> they are wired differently, so it makes sense to allow DTS authors to
> specify each explicitly.
>
> Signed-off-by: Grant Erickson <gerickson@nuovations.com>

Acked-by: Stefan Roese <sr@denx.de>

Best regards,
Stefan
