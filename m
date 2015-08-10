Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2BA2A1A026C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 07:48:58 +1000 (AEST)
Message-ID: <1439243331.7047.0.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/prom: Use DRCONF flags while processing
 detected LMBs
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org,  mikey@neuling.org
Date: Tue, 11 Aug 2015 07:48:51 +1000
In-Reply-To: <55C415C4.9080704@linux.vnet.ibm.com>
References: <1438866307-19637-1-git-send-email-khandual@linux.vnet.ibm.com>
 <55C415C4.9080704@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-08-07 at 07:49 +0530, Madhavan Srinivasan wrote:
> 
> On Thursday 06 August 2015 06:35 PM, Anshuman Khandual wrote:
> > This patch just replaces hard coded values with existing
> 
>   Please drop "This patch just" and start with "Replace hard ..."
> 
>   https://www.kernel.org/doc/Documentation/SubmittingPatches 

Yeah I rewrote it as:

    Replace hard coded values with existing DRCONF flags while procesing
    detected LMBs from the device tree. Does not change any functionality.


cheers
