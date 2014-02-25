Return-Path: <cody@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9281A2C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 07:35:31 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 13:35:29 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 41FB53E40048
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 13:35:27 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp07029.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1PIWkoW6947094
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 19:32:46 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s1PKcr5H018560
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 13:38:54 -0700
Message-ID: <530CFE7F.7030300@linux.vnet.ibm.com>
Date: Tue, 25 Feb 2014 12:35:11 -0800
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 05/11] powerpc: add hv_gpci interface header
References: <20140225033328.1D5652C030B@ozlabs.org>
In-Reply-To: <20140225033328.1D5652C030B@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/24/2014 07:33 PM, Michael Ellerman wrote:
> On Fri, 2014-14-02 at 22:02:09 UTC, Cody P Schafer wrote:
>> "H_GetPerformanceCounterInfo" (refered to as hv_gpci or just gpci from
>> here on) is an interface to retrieve specific performance counters and
>> other data from the hypervisor. All outputs have a fixed format (and
>> are represented as structs in this patch).
>
> I still see unused stuff in here, can you strip it back to just what we need.
> Same goes for the next patch.
>

Sure, I can remove the unused structures and enum entries (hadn't 
realized you wanted that in the last review).
