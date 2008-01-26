Return-Path: <olof@lixom.net>
Date: Fri, 25 Jan 2008 20:51:17 -0600
From: Olof Johansson <olof@lixom.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 3/3] Cell IOMMU static mapping support
Message-ID: <20080126025117.GA28066@lixom.net>
References: <edf2d9650b044e2bc21e9b74ad1044f4e5b6615c.1201257905.git.michael@ellerman.id.au>
	<9ce4678eef9e50908969eb1ef8470e307f3076ff.1201257905.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9ce4678eef9e50908969eb1ef8470e307f3076ff.1201257905.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 25, 2008 at 09:45:07PM +1100, Michael Ellerman wrote:
> Citing "release early release often", I'm posting this now as a mega-patch
> to get people looking at it. I'll try to split it up and make it look a
> little prettier before submitting it.
> 
> The intent of this patch is to setup (on certain machines) a "static" IOMMU
> mapping of all of memory, to reduce the overhead of the IOMMU. If anyone has
> a better name than "static" I'm all ears.
> 
> So instead of having an IOMMU window that we use to temporarily map things
> in and out of DMA'able space, at boot we create a 1:1 mapping for all of
> memory. This obviously only works for devices that can do 64-bit DMA.

I don't get it. Why not disable the iommu instead?


-Olof
