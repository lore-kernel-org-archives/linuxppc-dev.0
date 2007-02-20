Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 Feb 2007 13:22:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [RFC 2/3] zImage: SMP hold
Message-ID: <20070220022216.GG17818@localhost.localdomain>
References: <45D7A910.60702@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45D7A910.60702@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Feb 17, 2007 at 05:17:04PM -0800, Geoff Levand wrote:
> Add SMP secondary hold helper routines to the powerpc zImage
> bootwrapper.  For platforms which are entered with multiple cpus.
> These routines can be used to hold the secondary cpus until the
> kernel is ready for entry.

Could we have these functions in their own library module.  That way
they can be omitted in the wrappers for strictly-UP platforms (many
embedded), or platforms where the secondary CPUs are held in firmware
until the kernel releases.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
