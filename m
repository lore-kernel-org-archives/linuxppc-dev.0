Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17727.55569.981861.182079@cargo.ozlabs.ibm.com>
Date: Thu, 26 Oct 2006 07:37:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull powerpc.git 'merge' branch
In-Reply-To: <6908EBCA-E869-4949-8096-34717733E6C1@kernel.crashing.org>
References: <17727.901.368752.68802@cargo.ozlabs.ibm.com>
	<6908EBCA-E869-4949-8096-34717733E6C1@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, torvalds@osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> Can you hold off on the this.  The following patch is still under  
> discussion and the problem exists on more than just PPC.

The patch that I put in fixes the problem in the situation where it
was found, right?  That the problem may exist on other architectures
isn't a reason not to fix it here.

> > Scott Wood:
> >       [POWERPC] IPIC: Fix spinlock recursion in set_irq_handler

Paul.
