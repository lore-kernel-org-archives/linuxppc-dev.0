Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3DB4D1A0567
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 16:23:43 +1000 (AEST)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 97CF114018C
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 16:23:42 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 12 Aug 2015 11:53:39 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 385C4E005C
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 11:57:58 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7C6NHdu14745804
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 11:53:18 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7C6NGXJ027712
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 11:53:16 +0530
Message-ID: <55CAE654.3030106@linux.vnet.ibm.com>
Date: Wed, 12 Aug 2015 11:53:16 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
CC: linuxppc-dev@ozlabs.org, mikey@neuling.org
Subject: Re: [PATCH] powerpc/prom: Use DRCONF flags while processing detected
 LMBs
References: <1438866307-19637-1-git-send-email-khandual@linux.vnet.ibm.com>
 <55C415C4.9080704@linux.vnet.ibm.com>
 <1439243331.7047.0.camel@ellerman.id.au>
In-Reply-To: <1439243331.7047.0.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/11/2015 03:18 AM, Michael Ellerman wrote:
> On Fri, 2015-08-07 at 07:49 +0530, Madhavan Srinivasan wrote:
>> > 
>> > On Thursday 06 August 2015 06:35 PM, Anshuman Khandual wrote:
>>> > > This patch just replaces hard coded values with existing
>> > 
>> >   Please drop "This patch just" and start with "Replace hard ..."
>> > 
>> >   https://www.kernel.org/doc/Documentation/SubmittingPatches 
> Yeah I rewrote it as:
> 
>     Replace hard coded values with existing DRCONF flags while procesing
>     detected LMBs from the device tree. Does not change any functionality.

Thanks Michael.
