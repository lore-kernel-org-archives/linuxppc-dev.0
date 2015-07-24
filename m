Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B5FEA1A1C0A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 01:46:50 +1000 (AEST)
Message-ID: <55B25DDE.8090107@roeck-us.net>
Date: Fri, 24 Jul 2015 08:46:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Eric B Munson <emunson@akamai.com>,
 Ralf Baechle <ralf@linux-mips.org>
CC: Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@suse.cz>,
 linux-mm@kvack.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-am33-list@redhat.com, Geert Uytterhoeven <geert@linux-m68k.org>,
 Vlastimil Babka <vbabka@suse.cz>,
 linux-xtensa@linux-xtensa.org, linux-s390@vger.kernel.org,
 adi-buildroot-devel@lists.sourceforge.net,
 linux-arm-kernel@lists.infradead.org, linux-cris-kernel@axis.com,
 linux-parisc@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 2/6] mm: mlock: Add new mlock, munlock, and munlockall
 system calls
References: <1437508781-28655-1-git-send-email-emunson@akamai.com>
 <1437508781-28655-3-git-send-email-emunson@akamai.com>
 <20150721134441.d69e4e1099bd43e56835b3c5@linux-foundation.org>
 <1437528316.16792.7.camel@ellerman.id.au> <20150722141501.GA3203@akamai.com>
 <20150723065830.GA5919@linux-mips.org> <20150724143936.GE9203@akamai.com>
In-Reply-To: <20150724143936.GE9203@akamai.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/24/2015 07:39 AM, Eric B Munson wrote:
> On Thu, 23 Jul 2015, Ralf Baechle wrote:
>
>> On Wed, Jul 22, 2015 at 10:15:01AM -0400, Eric B Munson wrote:
>>
>>>>
>>>> You haven't wired it up properly on powerpc, but I haven't mentioned it because
>>>> I'd rather we did it.
>>>>
>>>> cheers
>>>
>>> It looks like I will be spinning a V5, so I will drop all but the x86
>>> system calls additions in that version.
>>
>> The MIPS bits are looking good however, so
>>
>> Acked-by: Ralf Baechle <ralf@linux-mips.org>
>>
>> With my ack, will you keep them or maybe carry them as a separate patch?
>
> I will keep the MIPS additions as a separate patch in the series, though
> I have dropped two of the new syscalls after some discussion.  So I will
> not include your ack on the new patch.
>
> Eric
>

Hi Eric,

next-20150724 still has some failures due to this patch set. Are those
being looked at (I know parisc builds fail, but there may be others) ?

Thanks,
Guenter
