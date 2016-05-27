Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rGJXn5T05zDqZp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 18:07:53 +1000 (AEST)
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rGJXm4QXMz9t3t
 for <linuxppc-dev@ozlabs.org>; Fri, 27 May 2016 18:07:52 +1000 (AEST)
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Fri, 27 May 2016 09:07:49 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 312591B08067
 for <linuxppc-dev@ozlabs.org>; Fri, 27 May 2016 09:08:47 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4R87kTL7012698
 for <linuxppc-dev@ozlabs.org>; Fri, 27 May 2016 08:07:46 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4R87ihU003420
 for <linuxppc-dev@ozlabs.org>; Fri, 27 May 2016 02:07:46 -0600
Subject: Re: [PATCH V10 00/28] Add new powerpc specific ELF core notes
To: Michael Ellerman <michael@ellerman.id.au>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
 <57062722.5090706@linux.vnet.ibm.com>
 <5EA48413-85A1-4CB7-8843-CE22B2BB1F08@ellerman.id.au>
 <570B54EB.90507@linux.vnet.ibm.com> <1460524468.30704.5.camel@ellerman.id.au>
 <5718F901.6010104@linux.vnet.ibm.com>
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, peterz@infradead.org, palves@redhat.com,
 emachado@linux.vnet.ibm.com, shuahkh@osg.samsung.com,
 akpm@linux-foundation.org, oleg@redhat.com, dhowells@redhat.com,
 Ulrich.Weigand@de.ibm.com, kirjanov@gmail.com, davej@redhat.com,
 tglx@linutronix.de, sukadev@linux.vnet.ibm.com, davem@davemloft.net,
 sam.bobroff@au1.ibm.com
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Message-ID: <5748004F.7040408@linux.vnet.ibm.com>
Date: Fri, 27 May 2016 10:07:43 +0200
MIME-Version: 1.0
In-Reply-To: <5718F901.6010104@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21/04/2016 18:00, Laurent Dufour wrote:
> On 13/04/2016 07:14, Michael Ellerman wrote:
>> On Mon, 2016-04-11 at 09:40 +0200, Laurent Dufour wrote:
>>> On 07/04/2016 23:49, Michael Ellerman wrote:
>>>> On 7 April 2016 7:23:46 pm AEST, Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:
>>>>> This series is required to handle TM state in CRIU.
>>>>> Is there a chance to get it upstream soon ?
>>>>
>>>> We were waiting on the gdb support to make sure it had some testing. If it's working for CRIU that would be a good data point, have you actually tested it with CRIU?
>>>
>>> I just started integrating it in CRIU, my basic tests didn't report any
>>> issue with the new ptrace API, but I can't state that it is bug free ;)
>>
>> Sure. But if it's working for CRIU that's at least postive :)
> 
> I did additional tests and the Anshuman's series is working fine for
> CRIU's support with the attached patch applied.
> 
> Michael, could you please applied the attached patch among the
> Anshuman's series ?

Hi Michael,

Is there any chance we get this series pushed in 4.7 ?

Thanks,
Laurent.
