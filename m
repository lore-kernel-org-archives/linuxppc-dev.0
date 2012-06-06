Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 72D39100955
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 19:24:12 +1000 (EST)
Message-ID: <1338974632.2749.87.camel@twins>
Subject: Re: [PATCH 1/2] uprobes: Pass probed vaddr to
 arch_uprobe_analyze_insn()
From: Peter Zijlstra <peterz@infradead.org>
To: ananth@in.ibm.com
Date: Wed, 06 Jun 2012 11:23:52 +0200
In-Reply-To: <20120606091950.GB6745@in.ibm.com>
References: <20120606091950.GB6745@in.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 lkml <linux-kernel@vger.kernel.org>, oleg@redhat.com,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-06-06 at 14:49 +0530, Ananth N Mavinakayanahalli wrote:
> +int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_stru=
ct *mm, loff_t vaddr)

Don't we traditionally use unsigned long to pass vaddrs?
