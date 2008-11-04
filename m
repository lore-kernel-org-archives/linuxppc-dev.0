Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1AEB0DDDF3
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Nov 2008 09:31:06 +1100 (EST)
Date: Tue, 4 Nov 2008 14:07:43 -0800
From: Greg KH <greg@kroah.com>
To: Jon Tollefson <kniht@linux.vnet.ibm.com>
Subject: Re: [stable] 16G related patches for stable kernel 2.6.27
Message-ID: <20081104220743.GE3516@kroah.com>
References: <4908CE18.3030205@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4908CE18.3030205@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, stable@kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 29, 2008 at 03:56:56PM -0500, Jon Tollefson wrote:
> Please consider the following patches for the 2.6.27 stable tree.
> 
> The first two allow a powerpc machine with more then 2 numa nodes
> to boot when 16G pages are enabled.  The third one allows a powerpc
> machine to boot if using 16G pages and the mem= boot param.
> 
> thanks,
> Jon
> 
> 
> powerpc: Reserve in bootmem lmb reserved regions that cross NUMA nodes
>     commit 8f64e1f2d1e09267ac926e15090fd505c1c0cbcb
> powerpc/numa: Make memory reserve code more robust
>     commit e81703724a966120ace6504c993bda9e084cbf3e
> powerpc: Don't use a 16G page if beyond mem= limits
>     commit 4792adbac9eb41cea77a45ab76258ea10d411173

I've queued up all of these.

thanks,

greg k-h
