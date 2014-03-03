Return-Path: <mgorman@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3053B2C00E8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2014 07:04:41 +1100 (EST)
Date: Mon, 3 Mar 2014 20:04:32 +0000
From: Mel Gorman <mgorman@suse.de>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: Panic on ppc64 with numa_balancing and !sparsemem_vmemmap
Message-ID: <20140303200432.GV6732@suse.de>
References: <20140219180200.GA29257@linux.vnet.ibm.com>
 <20140303172649.GU6732@suse.de> <874n3fxfeg.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <874n3fxfeg.fsf@linux.vnet.ibm.com>
Cc: riel@redhat.com, Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 04, 2014 at 12:45:19AM +0530, Aneesh Kumar K.V wrote:
> Mel Gorman <mgorman@suse.de> writes:
> 
> > On Wed, Feb 19, 2014 at 11:32:00PM +0530, Srikar Dronamraju wrote:
> >> 
> >> On a powerpc machine with CONFIG_NUMA_BALANCING=y and CONFIG_SPARSEMEM_VMEMMAP
> >> not enabled,  kernel panics.
> >> 
> >
> > This?
> 
> This one fixed that crash on ppc64
> 
> http://mid.gmane.org/1393578122-6500-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com
> 

Thanks.

-- 
Mel Gorman
SUSE Labs
