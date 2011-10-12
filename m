Return-Path: <hjk@hansjkoch.de>
Received: from www.hansjkoch.de (www.hansjkoch.de [178.63.77.200])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8F61FB6F18
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Oct 2011 03:21:13 +1100 (EST)
Date: Wed, 12 Oct 2011 18:20:54 +0200
From: "Hans J. Koch" <hjk@hansjkoch.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] UIO: Allow a UIO driver to override the default pgprot
 when we mmap
Message-ID: <20111012162053.GF21852@local>
References: <1318430616-20351-1-git-send-email-galak@kernel.crashing.org>
 <20111012153536.GC21852@local>
 <AEAF26D0-640A-4DD2-82FE-B3BD02662EEC@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AEAF26D0-640A-4DD2-82FE-B3BD02662EEC@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, "Hans J. Koch" <hjk@hansjkoch.de>, gregkh@suse.de,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 12, 2011 at 11:08:20AM -0500, Kumar Gala wrote:
> 
> On Oct 12, 2011, at 10:35 AM, Hans J. Koch wrote:
> 
> > On Wed, Oct 12, 2011 at 09:43:36AM -0500, Kumar Gala wrote:
> >> For some devices the default behavior of pgprot_noncached is not
> >> the correct flags for the address space.
> > 
> > For what devices? Can you give a real world usecase where this is needed?
> > 
> > Thanks,
> > Hans
> 
> In the Freescale Networking devices we have a coherent memory interface to our HW queuing system.  In that case we want to change the pgprot() to be cache-able instead of non-cached.

Could you please post the kernel part of that driver?

Thanks,
Hans
