Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9BE2D1A0591
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 10:10:07 +1000 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 27 May 2014 18:10:05 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 9E6F5C40003
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 18:10:03 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.ahe.boulder.ibm.com
 [9.17.195.167])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4S098ej11600226
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 02:09:08 +0200
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4S0A2ta020026
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 18:10:03 -0600
Date: Tue, 27 May 2014 17:09:58 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 1/2] powerpc: numa: enable USE_PERCPU_NUMA_NODE_ID
Message-ID: <20140528000958.GF4104@linux.vnet.ibm.com>
References: <20140516233945.GI8941@linux.vnet.ibm.com>
 <20140519181423.GL8941@linux.vnet.ibm.com>
 <20140527234420.GE4104@linux.vnet.ibm.com>
 <1401234974.8262.8.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1401234974.8262.8.camel@pasglop>
Cc: Lee Schermerhorn <lee.schermerhorn@hp.com>,
 Christoph Lameter <cl@linux-foundation.org>, Mel Gorman <mel@csn.ul.ie>,
 linux-mm@kvack.org, Anton Blanchard <anton@samba.org>,
 David Rientjes <rientjes@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28.05.2014 [09:56:14 +1000], Benjamin Herrenschmidt wrote:
> On Tue, 2014-05-27 at 16:44 -0700, Nishanth Aravamudan wrote:
> > > Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> > 
> > Ping on this and patch 2/2. Ben, would you be willing to pull these
> > into
> > your -next branch so they'd get some testing?
> > 
> > http://patchwork.ozlabs.org/patch/350368/
> > http://patchwork.ozlabs.org/patch/349838/
> > 
> > Without any further changes, these two help quite a bit with the slab
> > consumption on CONFIG_SLUB kernels when memoryless nodes are present.
> 
> I don't mind at all :-) I haven't really been following that story
> so I was waiting for the dust to settle and maybe acks from MM people
> but if you tell me they are good I'm prepared to trust you.

The patches themselves are pretty minimal and similar to the ia64
changes (and the affected code seems like it hasn't changed in some
time, beyond in the common code). I'd mostly like to get some
broad-range build & boot testing.

Also, is NUMA a sufficient symbol to depend, you think? I figure most of
the PPC NUMA systems are the pSeries/IBM variety, which is where I've
run into memoryless nodes in the first place.

Thanks,
Nish
