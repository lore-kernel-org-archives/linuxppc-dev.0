Return-Path: <dgibson@ozlabs.org>
Date: Tue, 11 Mar 2008 11:37:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] bootwrapper: Allow specifying of image
	physical offset
Message-ID: <20080311003705.GH11559@localhost.localdomain>
References: <Pine.LNX.4.64.0803071055200.8522@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0803071055200.8522@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 07, 2008 at 10:55:51AM -0600, Kumar Gala wrote:
> Normally we assume kernel images will be loaded at offset 0. However
> there are situations, like when the kernel itself is running at a non-zero
> physical address, that we don't want to load it at 0.
> 
> Allow the wrapper to take an offset.  We use this when building u-boot images.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Hrm.  It concerns me that with the patch as it stands,
CONFIG_MEMORY_START looks like a fairly universal option, but it will
only be respected on u-boot platforms (and only new u-boot, not cuboot
at that).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
