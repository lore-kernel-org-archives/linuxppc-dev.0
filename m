Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E2B721A0610
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 15:55:29 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 19 Feb 2016 14:55:29 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DC459357803F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 15:55:26 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1J4tIpF41287734
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 15:55:26 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1J4sssr021231
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 15:54:54 +1100
Message-ID: <56C6A00C.5030602@linux.vnet.ibm.com>
Date: Fri, 19 Feb 2016 10:24:36 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
CC: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [RFC 4/4] powerpc/mm: Rename global tracker for virtual to
 physical mapping
References: <1455711179-20357-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1455711179-20357-4-git-send-email-khandual@linux.vnet.ibm.com>
 <1455806240.5284.19.camel@ellerman.id.au>
In-Reply-To: <1455806240.5284.19.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/18/2016 08:07 PM, Michael Ellerman wrote:
> On Wed, 2016-02-17 at 17:42 +0530, Anshuman Khandual wrote:
> 
>> This renames the global list which tracks all the virtual to physical
>> mapping and also the global list which tracks all the available unused
>> vmemmap_hw_map node structures.
> 
> But why? Why are the new names *so* much better that we would want to go
> through all this churn?

Hmm, okay. Its kind of subjective but then its upto you.

> 
>> It also attempts to explain the purpose
>> of these global linked lists and points out a possible race condition.
> 
> I'm happy to take the comments.

Sure, will send across next time around separately.
