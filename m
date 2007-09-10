Return-Path: <dgibson@ozlabs.org>
Date: Mon, 10 Sep 2007 13:27:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Zhang Wei <wei.zhang@freescale.com>
Subject: Re: [PATCH 2/5] Add Freescale DMA engine driver maintainer.
Message-ID: <20070910032737.GB27828@localhost.localdomain>
References: <11891624353752-git-send-email-wei.zhang@freescale.com>
	<1189162437484-git-send-email-wei.zhang@freescale.com>
	<11891624382764-git-send-email-wei.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11891624382764-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 07, 2007 at 06:53:53PM +0800, Zhang Wei wrote:
> This patch adds Freescale DMA engine driver maintainer.

This is meaningless without the actual driver, so it shouldn't be a
separate patch.  Fold it into the patch that actually adds the driver
support.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
