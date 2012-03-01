Return-Path: <mgorman@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 99B9C1007D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2012 22:43:06 +1100 (EST)
Date: Thu, 1 Mar 2012 11:42:54 +0000
From: Mel Gorman <mgorman@suse.de>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] bootmem/sparsemem: remove limit constraint in
 alloc_bootmem_section
Message-ID: <20120301114254.GH1199@suse.de>
References: <1330112038-18951-1-git-send-email-nacc@us.ibm.com>
 <20120228154732.GE1199@suse.de>
 <20120229181233.GF5136@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20120229181233.GF5136@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@au1.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Robert Jennings <rcj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 29, 2012 at 10:12:33AM -0800, Nishanth Aravamudan wrote:
> <SNIP>
>
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> 

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
