Return-Path: <BATV+3592e8758989742b8edd+5468+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41pmsk2WzLzDr5t
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 17:03:38 +1000 (AEST)
Date: Sun, 12 Aug 2018 23:43:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] powerpc: Detect the presence of big-cores via
 "ibm,thread-groups"
Message-ID: <20180813064321.GA6039@infradead.org>
References: <1533792728-6304-1-git-send-email-ego@linux.vnet.ibm.com>
 <1533792728-6304-2-git-send-email-ego@linux.vnet.ibm.com>
 <20180809132743.GB42474@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180809132743.GB42474@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 09, 2018 at 06:27:43AM -0700, Srikar Dronamraju wrote:
> * Gautham R. Shenoy <ego@linux.vnet.ibm.com> [2018-08-09 11:02:07]:
> 
> > 
> >  int threads_per_core, threads_per_subcore, threads_shift;
> > +bool has_big_cores;
> >  cpumask_t threads_core_mask;
> >  EXPORT_SYMBOL_GPL(threads_per_core);
> >  EXPORT_SYMBOL_GPL(threads_per_subcore);
> >  EXPORT_SYMBOL_GPL(threads_shift);
> > +EXPORT_SYMBOL_GPL(has_big_cores);
> 
> Why do we need EXPORT_SYMBOL_GPL?

Because it is deeply internal, and in that matches the other related
exports.
