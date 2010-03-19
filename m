Return-Path: <jgunthorpe@obsidianresearch.com>
Received: from quartz.orcorp.ca (quartz.orcorp.ca [139.142.54.143])
	by ozlabs.org (Postfix) with ESMTP id 2F168B7CA6
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Mar 2010 17:06:27 +1100 (EST)
Date: Fri, 19 Mar 2010 00:06:21 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PPC: Skip over OF_DT_NOP when unflattening the device tree
Message-ID: <20100319060621.GC28042@obsidianresearch.com>
References: <20100309193021.GD30462@obsidianresearch.com>
	<1268977838.8599.53.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1268977838.8599.53.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 19, 2010 at 04:50:38PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2010-03-09 at 12:30 -0700, Jason Gunthorpe wrote:
> > NOPs within the property section are skipped, but NOPs between
> > OF_DT_END_NODE and OF_DT_BEGIN_NODE were not. My firmware NOPs out
> > entire nodes depending on various environment parameters.
> > 
> > of_scan_flat_dt already handles NOP more generally..
> 
> Good catch, though that code has now moved over to drivers/of
> and is a bit different. Grant is going to fix it up though.

Ah, I based the patch off 2.6.33.. 

Grant: let me know if you need some help/testing, nice to run into you
again.

Jason
