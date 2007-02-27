Return-Path: <dgibson@ozlabs.org>
Date: Tue, 27 Feb 2007 13:11:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: #cpus property
Message-ID: <20070227021151.GB1861@localhost.localdomain>
References: <9696D7A991D0824DBA8DFAC74A9C5FA302AA0181@az33exm25.fsl.freescale.net>
	<213956050aa89759f6329f518e46f42b@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <213956050aa89759f6329f518e46f42b@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 27, 2007 at 12:33:05AM +0100, Segher Boessenkool wrote:
> > Anyone know the origin of the #cpus property that seems to be in most 
> > of
> > the DTS files.  It seems to be documented nowhere.
> 
> It was there in the first DTS file to hit the kernel
> source tree.  Probably all others just copied that.

That sounds likely.  We should probably get rid of it, the kernel
doesn't use it.  BenH, Paulus, you can't see any use for this one?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
