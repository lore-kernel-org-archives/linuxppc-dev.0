Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F05C71A0103
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 14:20:04 +1000 (AEST)
Message-ID: <1440044404.13406.13.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/hvsi: Fix endianness issues in the HVSI driver
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Thu, 20 Aug 2015 14:20:04 +1000
In-Reply-To: <1440034811.13406.9.camel@ellerman.id.au>
References: <1438334990-11765-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1438649494.9418.0.camel@ellerman.id.au>
 <55D4FAE9.7000504@linux.vnet.ibm.com>
 <1440034811.13406.9.camel@ellerman.id.au>
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

On Thu, 2015-08-20 at 11:40 +1000, Michael Ellerman wrote:
> On Wed, 2015-08-19 at 23:53 +0200, Laurent Dufour wrote:
> > On 04/08/2015 02:51, Michael Ellerman wrote:
> > > On Fri, 2015-07-31 at 11:29 +0200, Laurent Dufour wrote:
> > >> This patch fixes several endianness issues detected when running the HVSI
> > >> driver in little endian mode.
> > >>
> > >> These issues are raised in little endian mode because the data exchanged in
> > >> memory between the kernel and the hypervisor has to be in big endian
> > >> format.

...
>
> So it seems you fixed all the issues, or at least all the issues we can detect
> with sparse. So I'll merge this as-is with an updated changelog.

Unless Greg wants to merge it? But I'll assume he's not bothered unless he says
otherwise as it's a powerpc only driver.

cheers
