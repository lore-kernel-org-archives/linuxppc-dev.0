Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 265551A04A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 13:17:20 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 22 Feb 2016 19:17:19 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id F23081FF002A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 19:05:26 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1N2HHMQ29098232
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 19:17:17 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1N2HGH0022850
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 19:17:16 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Scott Wood <oss@buserror.net>, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 00/29] Book3s abstraction in preparation for new MMU
 model
In-Reply-To: <1456192777.2463.131.camel@buserror.net>
References: <1454923241-6681-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87zivaxbll.fsf@linux.vnet.ibm.com> <1456192777.2463.131.camel@buserror.net>
Date: Tue, 23 Feb 2016 07:47:11 +0530
Message-ID: <87vb5ggogo.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <oss@buserror.net> writes:

> On Tue, 2016-02-09 at 18:52 +0530, Aneesh Kumar K.V wrote:
>> 
>> Hi Scott,
>> 
>> I missed adding you on CC:, Can you take a look at this and make sure we
>> are not breaking anything on freescale.
>
> I'm having trouble getting it to apply cleanly.  Do you have a git tree I can
> test?
>


https://github.com/kvaneesh/linux/commits/radix-mmu-v2

-aneesh
