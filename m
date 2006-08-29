Return-Path: <christoph@schroedinger.engr.sgi.com>
Received: from omx2.sgi.com (omx2-ext.sgi.com [192.48.171.19])
	by ozlabs.org (Postfix) with ESMTP id 813F867A5E
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 10:56:29 +1000 (EST)
Date: Tue, 29 Aug 2006 16:57:35 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: libnuma interleaving oddness
In-Reply-To: <20060829231545.GY5195@us.ibm.com>
Message-ID: <Pine.LNX.4.64.0608291655160.22397@schroedinger.engr.sgi.com>
References: <20060829231545.GY5195@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: Christoph Lameter <christoph@schroedinger.engr.sgi.com>
Cc: linux-mm@kvack.org, lnxninja@us.ibm.com, ak@suse.de,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 29 Aug 2006, Nishanth Aravamudan wrote:

> I don't know if this is a libnuma bug (I extracted out the code from
> libnuma, it looked sane; and even reimplemented it in libhugetlbfs for
> testing purposes, but got the same results) or a NUMA kernel bug (mbind
> is some hairy code...) or a ppc64 bug or maybe not a bug at all.
> Regardless, I'm getting somewhat inconsistent behavior. I can provide
> more debugging output, or whatever is requested, but I wasn't sure what
> to include. I'm hoping someone has heard of or seen something similar?

Are you setting the tasks allocation policy before the allocation or do 
you set a vma based policy? The vma based policies will only work for 
anonymous pages.
