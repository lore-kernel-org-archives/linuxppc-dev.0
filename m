Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D189AB6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 19:40:22 +1000 (EST)
Received: by werh12 with SMTP id h12so4134614wer.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jun 2012 02:40:18 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 6 Jun 2012 11:40:15 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH 1/2] uprobes: Pass probed vaddr to
 arch_uprobe_analyze_insn()
Message-ID: <20120606094014.GD9495@gmail.com>
References: <20120606091950.GB6745@in.ibm.com> <1338974632.2749.87.camel@twins>
 <20120606093744.GB29580@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120606093744.GB29580@in.ibm.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 oleg@redhat.com, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Ananth N Mavinakayanahalli <ananth@in.ibm.com> wrote:

> On Wed, Jun 06, 2012 at 11:23:52AM +0200, Peter Zijlstra wrote:
> > On Wed, 2012-06-06 at 14:49 +0530, Ananth N Mavinakayanahalli wrote:
> > > +int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, loff_t vaddr)
> > 
> > Don't we traditionally use unsigned long to pass vaddrs?
> 
> Right. But the vaddr we pass here is vma_info->vaddr which is loff_t.
> I guess I should've made that clear in the patch description.

Why not fix struct vma_info's vaddr type?

Thanks,

	Ingo
