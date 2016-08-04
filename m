Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4ld436LszDqSC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 19:53:44 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/book3s: Fix MCE console messages for
 unrecoverable MCE.
In-Reply-To: <4c34d692-7331-254e-5f25-d08b2037ff44@linux.vnet.ibm.com>
References: <147028600879.16761.7577655191376075114.stgit@jupiter.in.ibm.com>
 <20160804080521.GA19251@kroah.com>
 <4c34d692-7331-254e-5f25-d08b2037ff44@linux.vnet.ibm.com>
Date: Thu, 04 Aug 2016 19:53:43 +1000
Message-ID: <87eg64g8rc.fsf@concordia.ellerman.id.au>
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

Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> writes:

> On 08/04/2016 01:35 PM, Greg KH wrote:
>> On Thu, Aug 04, 2016 at 10:16:48AM +0530, Mahesh J Salgaonkar wrote:
>>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>>
>>> When machine check occurs with MSR(RI=0), it means MC interrupt is
>>> unrecoverable and kernel goes down to panic path. But the console
>>> message still shows it as recovered. This patch fixes the MCE console
>>> messages.
>>>
>>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> 
>> <formletter>
>> 
>> This is not the correct way to submit patches for inclusion in the
>> stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
>> for how to do this properly.
>> 
>> </formletter>
>
> Ouch. My mistake. Will follow Documentation/stable_kernel_rules.txt

Additionally I appreciate it if you can add a Fixes: line. Which
indicates the commit that introduced the bug you are fixing. It is
documented in Documentation/SubmittingPatches.

In this case it looks like it would be:

Fixes: 36df96f8acaf ("powerpc/book3s: Decode and save machine check event.")

cheers
