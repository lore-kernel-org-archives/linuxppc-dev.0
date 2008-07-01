Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id A7542DE4CC
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 05:42:49 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Grant Erickson <gerickson@nuovations.com>
Subject: Re: [PATCH v2] Parameterize EMAC Multicast Match Handling
Date: Tue, 1 Jul 2008 21:42:14 +0200
References: <C48FC1C4.10254%gerickson@nuovations.com>
In-Reply-To: <C48FC1C4.10254%gerickson@nuovations.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807012142.14323.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 01 July 2008, Grant Erickson wrote:
> > Yes, this was my feeling too. Not the size of the dtb but more the
> > increased complexity of the EMAC device node. I would prefer Ben's idea
> > with this new compatible entry too.
>
> In terms of the device tree expression, you would both favor something akin
> to the following?
>
> -              compatible = "ibm,emac-405exr", "ibm,emac4";
> +              compatible = "ibm,emac-405exr", "ibm,emac4",
> "ibm,emac4sync";

If this is how IBM/AMCC call this "new" EMAC version, then yes.

Best regards,
Stefan
