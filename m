Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5FE971A0030
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 13:47:37 +1100 (AEDT)
Message-ID: <1422931655.4625.6.camel@ellerman.id.au>
Subject: Re: [PATCH v2 0/4] VPHN parsing fixes
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Date: Tue, 03 Feb 2015 13:47:35 +1100
In-Reply-To: <20150129190353.401248ab@bahia.local>
References: <20141217094007.16957.70423.stgit@bahia.local>
 <20150129190353.401248ab@bahia.local>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-01-29 at 19:03 +0100, Greg Kurz wrote:
> On Wed, 17 Dec 2014 10:40:46 +0100
> Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:
> > Hi,
> > 
> > This series addresses remarks from Ben and Michael (see individual patches).
> > The most notable changes are:
> > - the parsing code being pull out into a separate file in patch 3/4. This
> >   allows to write userland tests like the one below.
> > - a full rewrite of the parsing logic in patch 4/4
> > 
> 
> Ping ?

Sorry, lots of patches needing review.

This looks pretty good at a glance, but did you actually write a userspace test
for it? If so please send it. I'm happy to rework it into something that can go
in selftests.

cheers
