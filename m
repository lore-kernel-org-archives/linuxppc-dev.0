Return-Path: <dgibson@ozlabs.org>
Date: Thu, 19 Apr 2007 12:59:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/10] Re-organize Kconfig code for 4xx in arch/powerpc
Message-ID: <20070419025916.GA5457@localhost.localdomain>
References: <20070418063517.GB29312@localhost.localdomain>
	<20070418063626.4E05CDDE3B@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070418063626.4E05CDDE3B@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul, I think this one is ready to merge, providing it doesn't
conflict with anything in-progress in Kumar's Kconfig cleanup work.
Kumar, can you comment?

On Wed, Apr 18, 2007 at 04:36:26PM +1000, David Gibson wrote:
> Now that we always take a device tree in arch/powerpc, there's no good
> reason not to allow a single kernel to support multiple embedded 4xx
> boards - the correct platform code can be selected based on the device
> tree information.
> 
> Therefore, this patch re-arranges the 4xx Kconfig code to allow this.
> In addition we:
> 	- use "select" instead of depends to configure the correct
> 	  config options for specific 4xx CPUs and workarounds, which
> 	  makes the information about specific boards and CPUs less
> 	  scattered.
> 	- Some old, unused (in arch/powerpc) config options are
> 	  removed: WANT_EARLY_SERIAL, IBM_OCP, etc.
> 
> Signed-off-by: David Gibson <dwg@au1.ibm.com>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
