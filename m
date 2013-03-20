Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 51C922C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 03:09:48 +1100 (EST)
Date: Wed, 20 Mar 2013 17:07:28 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH] powerpc/uprobes: teach uprobes to ignore gdb breakpoints
Message-ID: <20130320160728.GB20352@redhat.com>
References: <20130320104033.GA19844@in.ibm.com>
 <20130320122639.GA29541@redhat.com> <20130320124301.GA30887@redhat.com>
 <20130320154245.GB8246@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130320154245.GB8246@in.ibm.com>
Cc: ppcdev <linuxppc-dev@lists.ozlabs.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/20, Ananth N Mavinakayanahalli wrote:
>
> On Wed, Mar 20, 2013 at 01:43:01PM +0100, Oleg Nesterov wrote:
> > On 03/20, Oleg Nesterov wrote:
> > >
> > > But we did not install UPROBE_SWBP_INSN. Is it fine? I hope yes, just to
> > > verify. If not, we need 2 definitions. is_uprobe_insn() should still check
> > > insns == UPROBE_SWBP_INSN, and is_swbp_insn() should check is_trap().
> > >
> > > And I am just curious, could you explain how X and UPROBE_SWBP_INSN
> > > differ?
> >
> > IOW, if I wasn't clear... Lets forget about gdb/etc for the moment.
> > Suppose we apply the patch below. Will uprobes on powerpc work?
> >
> > If yes, then your patch should be fine. If not, we probably need more
> > changes.
>
> Yes, it will work fine.

Even if this new insn is conditional?

Oleg.
