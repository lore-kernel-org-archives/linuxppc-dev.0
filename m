Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVWyC5K0tzDqld
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 15:23:47 +1000 (AEST)
Message-ID: <1466054627.5400.5.camel@ellerman.id.au>
Subject: Re: kernel bug in "Drop WIMG in favour of new constants"?
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Darrick J. Wong" <darrick.wong@oracle.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Date: Thu, 16 Jun 2016 15:23:47 +1000
In-Reply-To: <20160616043340.GB22590@birch.djwong.org>
References: <20160616043340.GB22590@birch.djwong.org>
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

On Wed, 2016-06-15 at 21:33 -0700, Darrick J. Wong wrote:

> Hi Aneesh,
> 
> I noticed when trying out 4.7-rc3 on qemu-2.5 that the kernel no longer
> boots.  4.6 booted just fine, so I bisected the kernel to the commit
> 30bda41aba4efb2370c97e2cbe7385de93ccc372, which is "powerpc/mm: Drop WIMG in
> favour of new constants".  The changelog suggests that the KVM changes need
> closer review, and here's an actual crash:
> 
> (I can send libvirt's machine xml, .config, and full dmesg if that helps.)

Yes please.

I'm successfully booting 4.7-rc's on qemu (2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.1)).

cheers
