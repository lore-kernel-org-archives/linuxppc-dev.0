Return-Path: <dgibson@ozlabs.org>
Date: Tue, 8 May 2007 10:20:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 01/13] Clean up formatting in
	Documentation/booting-without-of.txt.
Message-ID: <20070508002021.GF7449@localhost.localdomain>
References: <20070507182907.GA26897@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070507182907.GA26897@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 07, 2007 at 01:29:07PM -0500, Scott Wood wrote:
> 1. Clean up whitespace issues (the indentation level of SOC device bindings
> was moving around as one goes through the list).
> 
> 2. Number QE devices with numbers rather than roman numerals; it's rather
> confusing to have two "i)"s right next to each other, especially without
> additional indentation.
> 
> 3. Label flash chip nodes as "j)" (the next one in sequence), not "g)"
> (which is used by Freescale SOC SEC Security Engines).
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: David Gibson <dwg@au1.ibm.com>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
