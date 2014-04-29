Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C35691400FE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 19:35:53 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 29 Apr 2014 19:35:52 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 51D302BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 19:35:50 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3T9ZYq07799076
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 19:35:35 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3T9XbGA026659
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 19:33:38 +1000
Message-ID: <535F71EA.6070604@linux.vnet.ibm.com>
Date: Tue, 29 Apr 2014 15:03:30 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V3 1/2] mm: move FAULT_AROUND_ORDER to arch/
References: <1398675690-16186-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1398675690-16186-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20140428090649.GD27561@twins.programming.kicks-ass.net>
In-Reply-To: <20140428090649.GD27561@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, riel@redhat.com, rusty@rustcorp.com.au,
 dave.hansen@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ak@linux.intel.com, paulus@samba.org, mgorman@suse.de,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 28 April 2014 02:36 PM, Peter Zijlstra wrote:
> On Mon, Apr 28, 2014 at 02:31:29PM +0530, Madhavan Srinivasan wrote:
>> +unsigned int fault_around_order = CONFIG_FAULT_AROUND_ORDER;
> 
> __read_mostly?
> 
Agreed. Will add it.

Thanks for review.
With regards
Maddy
