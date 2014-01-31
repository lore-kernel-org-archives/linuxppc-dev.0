Return-Path: <cody@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 190242C00B5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Feb 2014 07:59:19 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Fri, 31 Jan 2014 13:59:17 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 3712E3E4004F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 13:59:15 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp07029.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0VIuimF6947288
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 19:56:45 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s0VL2Vjo005234
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 14:02:32 -0700
Message-ID: <52EC0E9B.8020406@linux.vnet.ibm.com>
Date: Fri, 31 Jan 2014 12:59:07 -0800
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 0/8] Add support for PowerPC Hypervisor supplied
 performance counters
References: <1389916434-2288-1-git-send-email-cody@linux.vnet.ibm.com>
 <1390354379.11104.3.camel@concordia> <52E05E49.3010903@linux.vnet.ibm.com>
In-Reply-To: <52E05E49.3010903@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/22/2014 04:11 PM, Cody P Schafer wrote:
> On 01/21/2014 05:32 PM, Michael Ellerman wrote:
>> On Thu, 2014-01-16 at 15:53 -0800, Cody P Schafer wrote:
>>> These patches add basic pmus for 2 powerpc hypervisor interfaces to obtain
>>> performance counters: gpci ("get performance counter info") and 24x7.

Any comments on/things that need fixing for this patch set to be merged?
