Return-Path: <dgibson@ozlabs.org>
Date: Thu, 18 Dec 2008 12:54:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Erickson <gerickson@nuovations.com>
Subject: Re: [PATCH v2] powerpc/4xx: DTS: Add Add'l SDRAM0 Compatible and
	Interrupt Info
Message-ID: <20081218015440.GB12194@yookeroo.seuss>
References: <1229563900-10447-1-git-send-email-gerickson@nuovations.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1229563900-10447-1-git-send-email-gerickson@nuovations.com>
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 17, 2008 at 05:31:40PM -0800, Grant Erickson wrote:
> Added additional information for type and compatibility strings and
> interrupt information to the SDRAM0 memory-controller device tree
> nodes for AMCC PowerPC 405EX[r]-based boards to facilitate binding
> with the new "ibm,sdram-4xx-ddr2" EDAC memory controller adapter driver.
> 
> Signed-off-by: Grant Erickson <gerickson@nuovations.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
