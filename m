Return-Path: <ananth@in.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8227AB6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 20:22:43 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Wed, 6 Jun 2012 06:22:40 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id B035B38C8026
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 06:22:37 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q56AMbsw150360
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jun 2012 06:22:37 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q56AMZu2013223
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jun 2012 06:22:36 -0400
Date: Wed, 6 Jun 2012 15:52:31 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/2] uprobes: Pass probed vaddr to
 arch_uprobe_analyze_insn()
Message-ID: <20120606102230.GC29580@in.ibm.com>
References: <20120606091950.GB6745@in.ibm.com>
 <1338974632.2749.87.camel@twins> <20120606093744.GB29580@in.ibm.com>
 <20120606094014.GD9495@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120606094014.GD9495@gmail.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 oleg@redhat.com, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
 linuxppc-dev@lists.ozlabs.org
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 06, 2012 at 11:40:15AM +0200, Ingo Molnar wrote:
> 
> * Ananth N Mavinakayanahalli <ananth@in.ibm.com> wrote:
> 
> > On Wed, Jun 06, 2012 at 11:23:52AM +0200, Peter Zijlstra wrote:
> > > On Wed, 2012-06-06 at 14:49 +0530, Ananth N Mavinakayanahalli wrote:
> > > > +int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, loff_t vaddr)
> > > 
> > > Don't we traditionally use unsigned long to pass vaddrs?
> > 
> > Right. But the vaddr we pass here is vma_info->vaddr which is loff_t.
> > I guess I should've made that clear in the patch description.
> 
> Why not fix struct vma_info's vaddr type?

Agreed. Will fix and send v2.

Ananth
