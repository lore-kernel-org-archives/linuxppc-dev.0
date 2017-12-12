Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yx0Np2QhFzDrW4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 00:02:50 +1100 (AEDT)
Date: Tue, 12 Dec 2017 14:02:46 +0100
From: Torsten Duwe <duwe@lst.de>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org
Subject: Re: [PATCH] On ppc64le we HAVE_RELIABLE_STACKTRACE
Message-ID: <20171212130246.GA4391@lst.de>
References: <20171004152516.25803-1-kamalesh@linux.vnet.ibm.com>
 <20171005124313.GA25100@lst.de>
 <9f388c9a-8d74-865a-b113-f77322918b39@linux.vnet.ibm.com>
 <20171017144733.GB2136@lst.de>
 <95e6f942-88b7-0208-0eb0-2f5462aec410@linux.vnet.ibm.com>
 <20171020120739.GA20306@lst.de> <1508547548.5662.2.camel@gmail.com>
 <39bb7180-1adf-4df6-c9ba-c6f92754767f@linux.vnet.ibm.com>
 <20171212113912.GA1907@lst.de>
 <alpine.LSU.2.21.1712121308440.21907@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LSU.2.21.1712121308440.21907@pobox.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 12, 2017 at 01:12:37PM +0100, Miroslav Benes wrote:
> 
> I think that this is not enough. You need to also implement 
> save_stack_trace_tsk_reliable() for powerpc defined as __weak in 
> kernel/stacktrace.c. See arch/x86/kernel/stacktrace.c for reference, but I 
> think it would be much much simpler here given the changelog description.

Is there an exhaustive, definite, non-x86-centric description of the cases
this function needs to look for? Maybe some sort of formal specification?

	Torsten
