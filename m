Return-Path: <hjk@hansjkoch.de>
Received: from www.hansjkoch.de (www.hansjkoch.de [178.63.77.200])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B280EB6F62
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Oct 2011 07:23:55 +1100 (EST)
Date: Wed, 12 Oct 2011 22:23:32 +0200
From: "Hans J. Koch" <hjk@hansjkoch.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] uio: Support 36-bit physical addresses on 32-bit systems
Message-ID: <20111012202332.GG21852@local>
References: <1318430145-19898-1-git-send-email-galak@kernel.crashing.org>
 <20111012153229.GB21852@local> <20111012161931.GE21852@local>
 <38B65690-DA92-4923-B2A4-6523DDDA579A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <38B65690-DA92-4923-B2A4-6523DDDA579A@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, "Hans J. Koch" <hjk@hansjkoch.de>,
 Kai Jiang <Kai.Jiang@freescale.com>, gregkh@suse.de,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 12, 2011 at 01:40:22PM -0500, Kumar Gala wrote:
> 
> On Oct 12, 2011, at 11:19 AM, Hans J. Koch wrote:
> 
> > On Wed, Oct 12, 2011 at 05:32:29PM +0200, Hans J. Koch wrote:
> >> On Wed, Oct 12, 2011 at 09:35:45AM -0500, Kumar Gala wrote:
> >>> From: Kai Jiang <Kai.Jiang@freescale.com>
> >>> 
> >>> To support >32-bit physical addresses for UIO_MEM_PHYS type we need to
> >>> extend the width of 'addr' in struct uio_mem.  Numerous platforms like
> >>> embedded PPC, ARM, and X86 have support for systems with larger physical
> >>> address than logical.
> >>> 
> >>> Since 'addr' may contain a physical, logical, or virtual address the
> >>> easiest solution is to just change the type to 'unsigned long long'
> >>> regardless of which type is utilized.
> >> 
> >> No. There's phys_addr_t for that purpose, defined in include/linux/types.h.
> >> Please use that.
> > 
> > I forgot: If you resend this, please update the documentation as well.
> > (Documentation/DocBook/uio-howto.tmpl)
> 
> What would you look added or modified here?

struct uio_mem ?

Hans

> 
> - k
