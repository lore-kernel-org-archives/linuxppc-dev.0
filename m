Return-Path: <dgibson@ozlabs.org>
Date: Thu, 3 Feb 2011 10:06:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 1/6] powerpc: Move udbg_early_init() after
	early_init_devtree()
Message-ID: <20110202230643.GF3032@yookeroo>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1296586126-32765-2-git-send-email-shaggy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296586126-32765-2-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 01, 2011 at 12:48:41PM -0600, Dave Kleikamp wrote:
> so that it can use information from the device tree.

Hrm.  On the other hand this means that the early_init_devtree() code
can't benefit from hardcoded early debugging.  Since you don't
actually appear to use devtree information in udbg_early_init() in the
latest series, I'd suggest dropping this patch.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
