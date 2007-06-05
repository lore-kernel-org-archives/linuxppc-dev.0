Return-Path: <dgibson@ozlabs.org>
Date: Tue, 5 Jun 2007 13:01:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 3/3] powerpc: Update holly to use new dts wrapping feature
Message-ID: <20070605030115.GB22680@localhost.localdomain>
References: <20070531195136.GA3699@mag.az.mvista.com>
	<20070531195615.GC3818@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070531195615.GC3818@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, David Gibson <dgibson@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 31, 2007 at 12:56:15PM -0700, Mark A. Greer wrote:
> 
> The holly support currently has separate rules to wrap its device tree
> with its zImage.  This can now be done automatically without the extra
> rules so update holly support to use the automatic feature.
> 
> Signed-off-by: Mark A. Greer <mgreer@mista.com>

Works for me.

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
