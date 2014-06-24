Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 10FC31A0175
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 17:12:19 +1000 (EST)
Message-ID: <1403593937.14956.4.camel@concordia>
Subject: Re: [PATCH] powerpc/kvm: Fix build break with
 CONFIG_KVM_BOOK3S_64_HV=y
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Date: Tue, 24 Jun 2014 17:12:17 +1000
In-Reply-To: <20140624065127.GA4836@js1304-P5Q-DELUXE>
References: <1403591807-9550-1-git-send-email-mpe@ellerman.id.au>
 <20140624065127.GA4836@js1304-P5Q-DELUXE>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, agraf@suse.de,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-06-24 at 15:51 +0900, Joonsoo Kim wrote:
> On Tue, Jun 24, 2014 at 04:36:47PM +1000, Michael Ellerman wrote:
> > Commit e58e263 "PPC, KVM, CMA: use general CMA reserved area management
> > framework" in next-20140624 removed arch/powerpc/kvm/book3s_hv_cma.c but
> > neglected to update the Makefile, thus breaking the build.
> > 
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > ---
> > 
> > Hi Andrew,
> > 
> > This is in your akpm-current and is breaking some of the builds for
> > powerpc in linux-next. Squashing this fix into the original patch would
> > be best for us.
> > 
> 
> I sent really same patch 10 minutes ago. :)

Haha, oh well, I should have had a coffee instead :)

cheers
