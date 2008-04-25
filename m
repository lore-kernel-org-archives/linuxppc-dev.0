Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 409EEDDDF6
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 17:22:18 +1000 (EST)
Date: Fri, 25 Apr 2008 09:22:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH] powerpc copy_siginfo_from_user32
Message-ID: <20080425072207.GA23053@lst.de>
References: <20080419221924.424EF27037C@magilla.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080419221924.424EF27037C@magilla.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 19, 2008 at 03:19:24PM -0700, Roland McGrath wrote:
> Hi.  I posted this before, but I don't see it in any of your powerpc.git
> trees.  Can you push this upstream ASAP?  It would make life easier for me
> trying to merge some more generic changes (that would break powerpc builds
> without this going in first).

Any chance you could re-submit the patch to switch powerpc to the
generic PTRACE_GETSIGINFO using this aswell?
