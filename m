Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 777CB1A000B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 19:25:46 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 01:25:44 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 551471FF0025
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 01:13:51 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1G8PfdH29622426
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 01:25:41 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1G8PeRa006062
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 01:25:41 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH V2 12/29] powerpc/mm: Move hash64 specific defintions to
 seperate header
In-Reply-To: <20160215052449.GE3797@oak.ozlabs.ibm.com>
References: <1454923241-6681-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1454923241-6681-13-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160215052449.GE3797@oak.ozlabs.ibm.com>
Date: Tue, 16 Feb 2016 13:55:31 +0530
Message-ID: <87y4aldptw.fsf@linux.vnet.ibm.com>
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

Paul Mackerras <paulus@ozlabs.org> writes:

> On Mon, Feb 08, 2016 at 02:50:24PM +0530, Aneesh Kumar K.V wrote:
>> Also split pgalloc 64k and 4k headers
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> In the subject: s/defintions/definitions/; s/seperate/separate/
>
> A more detailed patch description would be good.  Apart from that,
>
> Reviewed-by: Paul Mackerras <paulus@samba.org>

Updated as below:

powerpc/mm: Move hash64 specific definitions to separate header

We will be adding a radix variant of these routines in the followup
patches. Move the hash64 variant into its own header so that we can
rename them easily later. Also split pgalloc 64k and 4k headers

Reviewed-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
