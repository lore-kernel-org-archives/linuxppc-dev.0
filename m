Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17799.32212.110299.916299@cargo.ozlabs.ibm.com>
Date: Tue, 19 Dec 2006 16:51:16 +1100
From: Paul Mackerras <paulus@samba.org>
To: timur@freescale.com
Subject: Re: [PATCH] Fix phy_read/write redefinition errors in ucc_geth_phy.c
In-Reply-To: <11660315492978-git-send-email-timur@freescale.com>
References: <11660315492978-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

timur@freescale.com writes:

> The local versions of phy_read() and phy_write() in ucc_geth_phy.c conflict
> with the prototypes in include/linux/phy.h, so this patch renames them, 
> moves them to the top of the file (while eliminating the redundant prototype),
> and makes them static.

You really need to send this patch to Jeff Garzik and the netdev
list.  If the driver won't compile in its current state in Linus' tree
because of the problem this fixes, make sure you make that point in
the patch commentary and explicitly ask Jeff to get the patch into
2.6.20.

Paul.
