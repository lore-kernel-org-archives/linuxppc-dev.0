Return-Path: <dgibson@ozlabs.org>
Date: Tue, 13 Mar 2007 20:54:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] ppc: Add support for bigger page sizes than 4KB on PPC44x
Message-ID: <20070313095412.GA14262@localhost.localdomain>
References: <200703122254.27087.sr@denx.de> <20070313094229.GA13567@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070313094229.GA13567@lst.de>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 13, 2007 at 10:42:29AM +0100, Christoph Hellwig wrote:
> On Mon, Mar 12, 2007 at 10:54:26PM +0100, Stefan Roese wrote:
> >  arch/ppc/Kconfig               |   10 ++++++++
> >  arch/ppc/kernel/head_44x.S     |   23 ++++++++++---------
> >  arch/ppc/kernel/misc.S         |   13 ++++++-----
> >  arch/ppc/kernel/vmlinux.lds.S  |   15 +++++++-----
> >  include/asm-ppc/page.h         |    6 ++++-
> >  include/asm-ppc/ppc_page_asm.h |   49 ++++++++++++++++++++++++++++++++++++++++
> 
> I though we'd given up on arch/ppc by now?
> Can you try to redo this over the arch/powerpc/ 44x port?

The arch/powerpc 44x port is hardly complete yet...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
