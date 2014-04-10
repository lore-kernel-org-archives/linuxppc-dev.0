Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A3D86140089
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 18:29:37 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 10 Apr 2014 13:59:34 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 8A019E0053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 14:03:45 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3A8TanC5439952
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 13:59:36 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3A8TU0T018176
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 13:59:31 +0530
Message-ID: <53465669.80701@linux.vnet.ibm.com>
Date: Thu, 10 Apr 2014 13:59:29 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V2 1/2] mm: move FAULT_AROUND_ORDER to arch/
References: <1396592835-24767-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1396592835-24767-2-git-send-email-maddy@linux.vnet.ibm.com>
 <533EDB63.8090909@intel.com> <5344A312.80802@linux.vnet.ibm.com>
 <20140409082008.GA10526@twins.programming.kicks-ass.net>
 <53456BE2.90905@intel.com>
In-Reply-To: <53456BE2.90905@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, riel@redhat.com, rusty@rustcorp.com.au,
 x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ak@linux.intel.com, paulus@samba.org, mgorman@suse.de,
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

On Wednesday 09 April 2014 09:18 PM, Dave Hansen wrote:
> On 04/09/2014 01:20 AM, Peter Zijlstra wrote:
>> This still misses out on Ben's objection that its impossible to get this
>> right at compile time for many kernels, since they can boot and run on
>> many different subarchs.
> 
> Completely agree.  The Kconfig-time stuff should probably just be a knob
> to turn it off completely, if anything.
> 

ok. Here is my thought. So to address Ben's concern, it would be better
to have this as a variable with a default value (and the platform can
override ride it). And a mm/Kconfig to disable it?
Kindly let me know whether this will work.

Thanks for review comments.
With regards
Maddy
