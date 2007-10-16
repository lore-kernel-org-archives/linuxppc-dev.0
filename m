Return-Path: <dgibson@ozlabs.org>
Date: Tue, 16 Oct 2007 15:18:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Merge dtc
Message-ID: <20071016051850.GB9052@localhost.localdomain>
References: <20071016050217.GA9052@localhost.localdomain>
	<B17BEF48-34FC-44E0-AC23-1DB7522EB198@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B17BEF48-34FC-44E0-AC23-1DB7522EB198@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 16, 2007 at 12:08:06AM -0500, Kumar Gala wrote:
> 
> On Oct 16, 2007, at 12:02 AM, David Gibson wrote:
> 
> > This very large patch incorporates a copy of dtc into the kernel
> > source, in arch/powerpc/boot/dtc-src.  This means that dtc is no
> > longer an external dependency to build kernels with configurations
> > which need a dtb file.
> >
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >
> > Too big for the list, full patch at
> > http://ozlabs.org/~dgibson/home/merge-dtc.patch
> 
> Dare I ask why we are including dtc in the kernel source tree?  We  

Well, we aren't unless Paul merges it..

> don't really have precedence for this and there are users outside of  
> linux for dtc.

Because having dtc as an external dependency is inconvenient.  This is
supposed to remain an embedded copy of dtc, not become the main dtc
repository.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
