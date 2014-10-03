Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 604F31A1ABF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 18:05:03 +1000 (EST)
Message-ID: <1412323499.2783.6.camel@concordia>
Subject: Re: [PATCH 1/3] powerpc: Don't build powernv for other platform
 defconfigs
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 03 Oct 2014 18:04:59 +1000
In-Reply-To: <20140924163410.4f1ad720@canb.auug.org.au>
References: <1411538232-31516-1-git-send-email-mpe@ellerman.id.au>
 <20140924163410.4f1ad720@canb.auug.org.au>
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

On Wed, 2014-09-24 at 16:34 +1000, Stephen Rothwell wrote:
> Hi Michael,
> 
> On Wed, 24 Sep 2014 15:57:10 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> > Because powernv arrived after these other platforms, the defconfigs
> > didn't have PPC_POWERNV disabled, and being default y it gets turned on.
> 
> Well, that raises the question of why PPC_POWERNV is default y at all?

I think that makes sense. With a bare config, you want all the platforms that
can be built to build, so that the kernel you produce is able to boot on as
many things as possible.

If you want a stripped down config for a particular target then we have
defconfigs that do that.

cheers
