Return-Path: <paulus@ozlabs.org>
Date: Thu, 12 May 2011 21:15:18 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 03/13] kvm/powerpc: Fix the build for 32-bit Book 3S
	(classic) processors
Message-ID: <20110512111518.GA3406@brick.ozlabs.ibm.com>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<20110511103950.GD2837@brick.ozlabs.ibm.com>
	<C5B8A119-56B6-467C-B3BD-01D5D7FA0773@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C5B8A119-56B6-467C-B3BD-01D5D7FA0773@suse.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 12, 2011 at 11:33:00AM +0200, Alexander Graf wrote:
> 
> Am 11.05.2011 um 12:39 schrieb Paul Mackerras <paulus@samba.org>:
> 
> > diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
> > index ae99af6..1a1b344 100644
> > --- a/arch/powerpc/kvm/book3s_rmhandlers.S
> > +++ b/arch/powerpc/kvm/book3s_rmhandlers.S
> > @@ -112,7 +112,9 @@ INTERRUPT_TRAMPOLINE    BOOK3S_INTERRUPT_MACHINE_CHECK
> > INTERRUPT_TRAMPOLINE    BOOK3S_INTERRUPT_DATA_STORAGE
> > INTERRUPT_TRAMPOLINE    BOOK3S_INTERRUPT_INST_STORAGE
> > INTERRUPT_TRAMPOLINE    BOOK3S_INTERRUPT_EXTERNAL
> > +#ifdef CONFIG_PPC_BOOK3S_64
> > INTERRUPT_TRAMPOLINE    BOOK3S_INTERRUPT_EXTERNAL_HV
> 
> Hrm - I don't remember putting this one here. When did it get into
> the tree and why wasn't I CC'ed?

It comes from commit a5d4f3ad3a ("powerpc: Base support for exceptions
using HSRR0/1", author Ben H.) in Ben's next branch.  He committed it
on April 20.

Paul.
