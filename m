Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6WLQ250KzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 13:47:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org
Cc: "'Kirill A. Shutemov'" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] selftests/powerpc/mm: Add a test for virtual address
 mapping
In-Reply-To: <adcab8f9-8c11-0678-a87f-8adb80d58a67@linux.vnet.ibm.com>
References: <20170412094112.13181-1-khandual@linux.vnet.ibm.com>
 <20170414221857.58171fce@neko>
 <adcab8f9-8c11-0678-a87f-8adb80d58a67@linux.vnet.ibm.com>
Date: Tue, 18 Apr 2017 13:47:54 +1000
Message-ID: <87y3uy74wl.fsf@concordia.ellerman.id.au>
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

Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:

> On 04/15/2017 01:48 AM, Michal Suchanek wrote:
>> Hello,
>> 
>> On Wed, 12 Apr 2017 15:11:12 +0530
>> Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:
>> 
>>> This verifies virtual address mapping below and above the
>>> 128TB range and makes sure that address returned are within
>>> the expected range depending upon the hint passed from the
>>> user space.
>> 
>> This description does not mention anything PPC specific. Can this be
>> generalized to work with Intel L5 enabled kernel as well?
>
> Hmm, I am not completely aware about the proposed mmap interface
> for 128TB and beyond till 512TB by Kirill on x86. If both powerpc
> and x86 will have the same semantics, then this test is generic
> enough to cover both the architectures and will move it into
> selftests/vm/ instead of current selftests/powerpc/mm.

I think it can be made generic, maybe it needs a few #ifdefs, but that's
fine for a selftest.

So yeah if you can move it to selftests/vm I think that would be better.

cheers
