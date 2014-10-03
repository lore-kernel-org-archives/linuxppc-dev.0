Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D8301A194D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 18:04:06 +1000 (EST)
Message-ID: <1412323443.2783.5.camel@concordia>
Subject: Re: [PATCH 3/3] powerpc/kdump: crash_dump.c needs to include io.h
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 03 Oct 2014 18:04:03 +1000
In-Reply-To: <20140924163657.74b23785@canb.auug.org.au>
References: <1411538232-31516-1-git-send-email-mpe@ellerman.id.au>
 <1411538232-31516-3-git-send-email-mpe@ellerman.id.au>
 <20140924163657.74b23785@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-09-24 at 16:36 +1000, Stephen Rothwell wrote:
> Hi Michael,
> 
> On Wed, 24 Sep 2014 15:57:12 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> > For __ioremap().
> 
> So does that mean that you really want this patch before 2/3 so that you
> don't introduce an unnecessary bisection breakage in ppc64_defconfig?

Yeah I guess it does.

cheers
