Return-Path: <douly.fnst@cn.fujitsu.com>
Received: from heian.cn.fujitsu.com (unknown [59.151.112.132])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xHxJw52nKzDrCv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 12:49:36 +1000 (AEST)
Subject: Re: [PATCH 05/11] powerpc/topology: Remove the unused parent_node()
 macro
To: Michael Ellerman <mpe@ellerman.id.au>, <linux-kernel@vger.kernel.org>
References: <1501076076-1974-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1501076076-1974-6-git-send-email-douly.fnst@cn.fujitsu.com>
 <87fudifwlj.fsf@concordia.ellerman.id.au>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <af21ddf9-10cc-d8ed-8962-9b6d4eb5230b@cn.fujitsu.com>
Date: Thu, 27 Jul 2017 10:49:31 +0800
MIME-Version: 1.0
In-Reply-To: <87fudifwlj.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="gbk"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

At 07/27/2017 10:21 AM, Michael Ellerman wrote:
> Dou Liyang <douly.fnst@cn.fujitsu.com> writes:
>
>> Commit a7be6e5a7f8d ("mm: drop useless local parameters of
>> __register_one_node()") removes the last user of parent_node().
>>
>> The parent_node() macro in POWERPC platform is unnecessary.
>>
>> Remove it for cleanup.
>>
>> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> ---
>>  arch/powerpc/include/asm/topology.h | 2 --
>>  1 file changed, 2 deletions(-)
>
> Thanks for doing this series.
>

It's my pleasure. :)

Sincerely,

	dou

> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>
> cheers
>
>
>
