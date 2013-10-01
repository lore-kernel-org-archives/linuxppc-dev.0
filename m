Return-Path: <alistair@popple.id.au>
Received: from ipmail05.adl6.internode.on.net (ipmail05.adl6.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:6:5])
 by ozlabs.org (Postfix) with ESMTP id AB1DC2C00DE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 17:13:06 +1000 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] iommu: Update platform initialisation of iommu to use
 it_page_shift
Date: Tue, 01 Oct 2013 17:13:16 +1000
Message-ID: <1815031.vnRpi07Wk2@mexican>
In-Reply-To: <20131001041228.GB17966@concordia>
References: <1380599650-9541-1-git-send-email-alistair@popple.id.au>
 <1380599650-9541-3-git-send-email-alistair@popple.id.au>
 <20131001041228.GB17966@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 1 Oct 2013 14:12:29 Michael Ellerman wrote:
> On Tue, Oct 01, 2013 at 01:54:10PM +1000, Alistair Popple wrote:
> > This patch initialises the iommu page size used for vio, cell, powernv
> > and pseries platforms to 4K.  It has been boot tested on a pseries
> > machine with vio.
> 
> This patch fixes the build errors introduced by the previous patch
> right?
> 
> In which case you need to rework it so that you introduce the new
> constants, use them everywhere, before removing the old constants. ie.
> the build should never break.

Thanks, I'll rework and resubmit.

Alistair

> cheers
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
