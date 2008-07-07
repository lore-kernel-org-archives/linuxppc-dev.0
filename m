Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id F281CDDEE7
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 15:59:01 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Grant Erickson <gerickson@nuovations.com>
Subject: Re: [PATCH v5] ibm_newemac: Parameterize EMAC Multicast Match Handling
Date: Mon, 7 Jul 2008 07:58:45 +0200
References: <1215303343-26410-1-git-send-email-gerickson@nuovations.com>
	<1215387012-6464-1-git-send-email-gerickson@nuovations.com>
In-Reply-To: <1215387012-6464-1-git-send-email-gerickson@nuovations.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200807070758.45828.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 07 July 2008, Grant Erickson wrote:
> Various instances of the EMAC core have varying: 1) number of address
> match slots, 2) width of the registers for handling address match slots,
> 3) number of registers for handling address match slots and 4) base
> offset for those registers.

<snip>

> Signed-off-by: Grant Erickson <gerickson@nuovations.com>

Acked-by: Stefan Roese <sr@denx.de>

Best regards,
Stefan
