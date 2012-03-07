Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Seth Jennings <sjenning@linux.vnet.ibm.com>
Subject: Re: tlb flushing on Power
In-reply-to: <4F54FE51.8070709@linux.vnet.ibm.com>
References: <4F2160B3.60708@linux.vnet.ibm.com>
 <4F216620.2010509@linux.vnet.ibm.com> <1327613953.24487.9.camel@pasglop>
 <4F32B354.7030306@linux.vnet.ibm.com> <1328735054.2903.29.camel@pasglop>
 <4F356C7E.3070608@linux.vnet.ibm.com> <4F3D38D3.4020903@linux.vnet.ibm.com>
 <1329424301.2892.23.camel@pasglop> <4F54FE51.8070709@linux.vnet.ibm.com>
Date: Wed, 07 Mar 2012 16:28:14 +1100
Message-ID: <6006.1331098094@neuling.org>
Cc: Robert Jennings <rcj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Nitin Gupta <ngupta@vflare.org>, Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Seth,

> Thanks for the help!  I was wondering if you could take a look at something
> for me.
> 
> I've been working on this staging driver (zsmalloc memory allocator)
> that does virtual mapping of two pages.
> 
> I have a github repo with the driver and the unsubmitted changes.  I'm
> trying to make to get the pte/tlb stuff working in a portable way:
> 
> git://github.com/spartacus06/linux.git (portable branch)
> 
> The experimental commits are the top 5 and the branch is based on
> Greg's staging-next + frontswap-v11 patches.
> 
> Could you take a look at the zs_map_object() and zs_unmap_object()
> in drivers/staging/zsmalloc/zsmalloc-main.c and see if they should
> work for PPC64?

I suggest you post the code directly to the list in reviewable chucks.
People are much more likely to review it if they don't have to download
some random git tree, checkout some branch, find the changes, etc etc.

If it's work in progress, mark it as an RFC patch and note what issues
you think still exist.  

Mikey
