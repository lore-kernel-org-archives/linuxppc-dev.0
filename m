Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6DA0A1A0BCB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 11:32:46 +1100 (AEDT)
Message-ID: <1417653165.9123.3.camel@concordia>
Subject: Re: [PATCH] powerpc: drop useless warning in eeh_init()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Thu, 04 Dec 2014 11:32:45 +1100
In-Reply-To: <20141203221422.GA4927@shangw>
References: <20141125161006.1995.31789.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <20141125222846.GA7662@shangw> <20141203152046.5c109d1f@bahia.local>
 <20141203221422.GA4927@shangw>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Greg Kurz <gkurz@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-12-04 at 09:14 +1100, Gavin Shan wrote:
> On Wed, Dec 03, 2014 at 03:20:46PM +0100, Greg Kurz wrote:
> >On Wed, 26 Nov 2014 09:28:47 +1100
> >Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> >> On Tue, Nov 25, 2014 at 05:10:06PM +0100, Greg Kurz wrote:
> >> >This is what we get in dmesg when booting a pseries guest and
> >> >the hypervisor doesn't provide EEH support.
> >
> >Ping ?
> 
> It's already in Michael's git tree.

Indeed.

It's also marked as "Under Review" in patchwork, which basically means I've
seen it and it's on its way into my tree unless you hear otherwise.

http://patchwork.ozlabs.org/patch/414753/

cheers
