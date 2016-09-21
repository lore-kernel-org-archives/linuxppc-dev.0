Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sf5fD5wRszDsgf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 14:06:28 +1000 (AEST)
Message-ID: <1474430783.3091.10.camel@russell.cc>
Subject: Re: [1/3] powerpc/eeh: Null check uses of eeh_pe_bus_get
From: Russell Currey <ruscur@russell.cc>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 21 Sep 2016 14:06:23 +1000
In-Reply-To: <3sf5YS0BVKz9sxN@ozlabs.org>
References: <3sf5YS0BVKz9sxN@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-09-21 at 14:02 +1000, Michael Ellerman wrote:
> On Mon, 2016-12-09 at 04:17:22 UTC, Russell Currey wrote:
> > 
> > eeh_pe_bus_get() can return NULL if a PCI bus isn't found for a given PE.
> > Some callers don't check this, and can cause a null pointer dereference
> > under certain circumstances.
> > 
> > Fix this by checking NULL everywhere eeh_pe_bus_get() is called.
> > 
> > Cc: stable #3.10+
> 
> This looks like it's a fix for 8a6b1bc70dbb ("powerpc/eeh: EEH core to handle
> special event") ?
> 
> Which was merged in v3.11-rc1.
> 
> If so I'll add a fixes line pointing at that commit and update the stable tag
> to
> v3.11+.

Thanks.

Also, the other two patches in this series shouldn't go to stable, that was my
mistake.

> 
> cheers
