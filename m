Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMzy00LJYzDqSQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 22:01:44 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 akpm@linux-foundation.org, Rik van Riel <riel@surriel.com>,
 Mel Gorman <mgorman@techsingularity.net>, paulus@ozlabs.org,
 benh@kernel.crashing.org
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc/mm/autonuma: Switch ppc64 to its own
 implementeation of saved write
In-Reply-To: <1487044759.21048.24.camel@neuling.org>
References: <1486609259-6796-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1486609259-6796-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1487044759.21048.24.camel@neuling.org>
Date: Tue, 14 Feb 2017 22:01:43 +1100
Message-ID: <871sv1m3xk.fsf@concordia.ellerman.id.au>
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

Michael Neuling <mikey@neuling.org> writes:

> On Thu, 2017-02-09 at 08:30 +0530, Aneesh Kumar K.V wrote:
>> With this our protnone becomes a present pte with READ/WRITE/EXEC bit cleared.
>> By default we also set _PAGE_PRIVILEGED on such pte. This is now used to help
>> us identify a protnone pte that as saved write bit. For such pte, we will
>> clear
>> the _PAGE_PRIVILEGED bit. The pte still remain non-accessible from both user
>> and kernel.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
>
> FWIW I've tested this, so:
>
> Acked-By: Michael Neuling <mikey@neuling.org>

In future if you've tested something then "Tested-by:" is the right tag
to use.

cheers
