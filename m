Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3stQxy5hP6zDsy4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 16:47:50 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org,
 Chris Smart <chris@distroguy.com>
Subject: Re: [PATCH] Fix "ibm,processor-radix-AP-encodings"
In-Reply-To: <CAOSf1CE2RJ2X_cB8nZz3UziFURqrqA7aLV+GVySY6k+8KPYTiA@mail.gmail.com>
References: <0612c46e-7e1b-3729-d84f-cefa886abb6d@gmail.com>
 <877f9wbv6j.fsf@linux.vnet.ibm.com>
 <CAOSf1CE2RJ2X_cB8nZz3UziFURqrqA7aLV+GVySY6k+8KPYTiA@mail.gmail.com>
Date: Tue, 11 Oct 2016 16:47:50 +1100
Message-ID: <87fuo35tdl.fsf@concordia.ellerman.id.au>
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

Oliver O'Halloran <oohall@gmail.com> writes:

> On Wed, Sep 28, 2016 at 12:43 PM, Aneesh Kumar K.V
> <aneesh.kumar@linux.vnet.ibm.com> wrote:
>> Balbir Singh <bsingharora@gmail.com> writes:
>>
>>> The top 3 bits of the lower order byte should contain the
>>> AP encoding, we assume the top 3 bits of the MSB.
>
> Balbir, could you reword this so it says "Currently we wrongly assume
> <blah>" or similar. The current commit message made me think you were
> changing it to look at the top 3 bits of the MSB rather than changing
> it look at the LSB.

Yeah please reword it to describe what the current code does, why it's
incorrect, and how we are fixing it.

cheers
