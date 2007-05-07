Return-Path: <dgibson@ozlabs.org>
Date: Mon, 7 May 2007 10:30:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 4/6] Device tree aware EMAC driver
Message-ID: <20070507003019.GB16165@localhost.localdomain>
References: <20070504055455.GA25922@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070504055455.GA25922@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is BenH's rewritten, device tree aware driver for the IBM/AMCC
EMAC, ethernet MAC controller ASIC found on various 4xx CPUs and also
the Axon bridge.  Tweaked to build on current kernels.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Patch is too too big for the list, get it from 
	http://ozlabs.org/~dgibson/home/tmp/powerpc-emac-new

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
