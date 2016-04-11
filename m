Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk26d05XkzDq9q
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 17:40:41 +1000 (AEST)
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qk26b6YzVz9t3p
 for <linuxppc-dev@ozlabs.org>; Mon, 11 Apr 2016 17:40:39 +1000 (AEST)
Received: from localhost
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 11 Apr 2016 08:40:34 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2EBAD1B08074
 for <linuxppc-dev@ozlabs.org>; Mon, 11 Apr 2016 08:41:12 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3B7eVCl51511484
 for <linuxppc-dev@ozlabs.org>; Mon, 11 Apr 2016 07:40:31 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3B7eTcW009663
 for <linuxppc-dev@ozlabs.org>; Mon, 11 Apr 2016 01:40:31 -0600
Subject: Re: [PATCH V10 00/28] Add new powerpc specific ELF core notes
To: Michael Ellerman <michael@ellerman.id.au>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
 <57062722.5090706@linux.vnet.ibm.com>
 <5EA48413-85A1-4CB7-8843-CE22B2BB1F08@ellerman.id.au>
Cc: shuahkh@osg.samsung.com, mikey@neuling.org, james.hogan@imgtec.com,
 avagin@openvz.org, Paul.Clothier@imgtec.com, peterz@infradead.org,
 palves@redhat.com, emachado@linux.vnet.ibm.com, oleg@redhat.com,
 davem@davemloft.net, dhowells@redhat.com, Ulrich.Weigand@de.ibm.com,
 kirjanov@gmail.com, davej@redhat.com, akpm@linux-foundation.org,
 sukadev@linux.vnet.ibm.com, tglx@linutronix.de, sam.bobroff@au1.ibm.com
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Message-ID: <570B54EB.90507@linux.vnet.ibm.com>
Date: Mon, 11 Apr 2016 09:40:27 +0200
MIME-Version: 1.0
In-Reply-To: <5EA48413-85A1-4CB7-8843-CE22B2BB1F08@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/04/2016 23:49, Michael Ellerman wrote:
> 
> 
> On 7 April 2016 7:23:46 pm AEST, Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:
>> On 16/02/2016 09:59, Anshuman Khandual wrote:
>>> 	This patch series adds twelve new ELF core note sections which can
>>> be used with existing ptrace request PTRACE_GETREGSET-SETREGSET for
>> accessing
>>> various transactional memory and other miscellaneous debug register
>> sets on
>>> powerpc platform.
>>
>> Hi Michael,
>>
>> This series is required to handle TM state in CRIU.
>> Is there a chance to get it upstream soon ?
> 
> We were waiting on the gdb support to make sure it had some testing. If it's working for CRIU that would be a good data point, have you actually tested it with CRIU?

I just started integrating it in CRIU, my basic tests didn't report any
issue with the new ptrace API, but I can't state that it is bug free ;)

Cheers,
Laurent.
