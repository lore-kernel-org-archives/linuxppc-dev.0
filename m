Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8gBw5tRTzDvR6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 20:48:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, duwe@lst.de,
 ast@kernel.org, viro@zeniv.linux.org.uk, chris@distroguy.com, oss@buserror.net,
 paul.gortmaker@windriver.com, oohall@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com, lsorense@csclub.uwaterloo.ca,
 bauerman@linux.vnet.ibm.com, paulus@samba.org, naveen.n.rao@linux.vnet.ibm.com,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] powerpc: Emulation support for load/store
 instructions on LE
In-Reply-To: <581ACDF2.1010409@linux.vnet.ibm.com>
References: <1478076783-2872-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1478076783-2872-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <20161103080412.68240cda@kryten> <581ACDF2.1010409@linux.vnet.ibm.com>
Date: Thu, 03 Nov 2016 20:48:20 +1100
Message-ID: <8737j8opwb.fsf@concordia.ellerman.id.au>
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

Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> writes:

> On Thursday 03 November 2016 02:34 AM, Anton Blanchard wrote:
>> Hi Ravi,
>>
>>> emulate_step() uses a number of underlying kernel functions that were
>>> initially not enabled for LE. This has been rectified since. So, fix
>>> emulate_step() for LE for the corresponding instructions.
>> Thanks. Should this be queued up for stable?
>
> Thanks Anton. Yes, this should go in stable.

It's fairly big for stable. Does it fix an actual bug? If so what, and
how bad is it, what's the user impact.

Can you also pinpoint which commit it "fixes"?

cheers
