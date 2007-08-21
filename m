Return-Path: <dgibson@ozlabs.org>
Date: Tue, 21 Aug 2007 12:44:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 12/20] bootwrapper: Add 8xx cuboot support.
Message-ID: <20070821024432.GL15469@localhost.localdomain>
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820174001.GK30562@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820174001.GK30562@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 20, 2007 at 12:40:01PM -0500, Scott Wood wrote:
> This allows booting on legacy, non-device-tree aware versions of
> U-boot.

Is this really sufficient for all 8xx platforms?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
