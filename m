Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A480E2C0085
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Dec 2013 22:08:28 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 20 Dec 2013 16:38:08 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 79C47E0057
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Dec 2013 16:40:35 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBKB7x6l26607672
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Dec 2013 16:37:59 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBKB84Sd005992
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Dec 2013 16:38:06 +0530
Message-ID: <52B424CF.3030809@linux.vnet.ibm.com>
Date: Fri, 20 Dec 2013 16:36:55 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V4 10/10] powerpc, perf: Cleanup SW branch filter list
 look up
References: <20131209062147.B874D2C00C6@ozlabs.org>
In-Reply-To: <20131209062147.B874D2C00C6@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mikey@neuling.org, ak@linux.intel.com, linux-kernel@vger.kernel.org,
 eranian@google.com, linuxppc-dev@ozlabs.org, acme@ghostprotocols.net,
 sukadev@linux.vnet.ibm.com, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/09/2013 11:51 AM, Michael Ellerman wrote:
> On Wed, 2013-04-12 at 10:32:42 UTC, Anshuman Khandual wrote:
>> This patch adds enumeration for all available SW branch filters
>> in powerpc book3s code and also streamlines the look for the
>> SW branch filter entries while trying to figure out which all
>> branch filters can be supported in SW.
> 
> This appears to patch code that was only added in 8/10 ?
> 
> Was there any reason not to do it the right way from the beginning?

No reason, merged this into the 8/10th patch. Working on the V5 of
this patchset. Will send out a draft V5 version for early review.

Regards
Anshuman
