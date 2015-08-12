Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 766F81A1DC4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 16:37:06 +1000 (AEST)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AA6851401AF
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 16:37:05 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 12 Aug 2015 12:07:03 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 18DF6E005E
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 12:11:21 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7C6ah5v28901552
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 12:06:46 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7C6agQG028884
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 12:06:42 +0530
Message-ID: <55CAE977.7020803@linux.vnet.ibm.com>
Date: Wed, 12 Aug 2015 12:06:39 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
CC: mikey@neuling.org
Subject: Re: [4/8] powerpc/slb: Add some helper functions to improve
 modularization
References: <20150812041117.CFFC91401CD@ozlabs.org>
In-Reply-To: <20150812041117.CFFC91401CD@ozlabs.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/12/2015 09:41 AM, Michael Ellerman wrote:
> On Wed, 2015-29-07 at 07:10:01 UTC, Anshuman Khandual wrote:
>> > This patch adds the following six helper functions to help improve
>> > modularization and readability of the code.
>> > 
>> > (1) slb_invalidate_all:		Invalidates the entire SLB
>> > (2) slb_invalidate:		Invalidates SLB entries present in PACA
>> > (3) mmu_linear_vsid_flags:	VSID flags for kernel linear mapping
>> > (4) mmu_virtual_vsid_flags:	VSID flags for kernel virtual mapping
>> > (5) mmu_vmemmap_vsid_flags:	VSID flags for kernel vmem mapping
>> > (6) mmu_io_vsid_flags:		VSID flags for kernel I/O mapping
> That's too many changes for one patch, it's certainly not a single logical change.
> 
> I'm happy with all the flag ones being done in a single patch, but please do
> the other two in separate patches.

Sure, will split this into three separate patches, also update the
in-code documentation as suggested on the [5/8] patch and then will
send out a new series.
