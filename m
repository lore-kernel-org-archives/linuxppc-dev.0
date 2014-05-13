Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205]) by ozlabs.org (Postfix) with ESMTP id 23611140096
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 May 2014 22:36:07 +1000 (EST)
Message-ID: <537211AC.6050901@roeck-us.net>
Date: Tue, 13 May 2014 05:35:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: powerpc/ppc64: Allow allmodconfig to build (finally !)
References: <1399874254.17624.85.camel@pasglop>	
 <20140513002846.GA29753@roeck-us.net> <1399972601.17624.169.camel@pasglop>
In-Reply-To: <1399972601.17624.169.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/13/2014 02:16 AM, Benjamin Herrenschmidt wrote:
> On Mon, 2014-05-12 at 17:28 -0700, Guenter Roeck wrote:
>
>> After applying this patch, I get
>>
>> arch/powerpc/kernel/exceptions-64s.S:269: Error: operand out of range
>> (0x000000000000814c is not between 0xffffffffffff8000 and 0x0000000000007ffc)
>> arch/powerpc/kernel/exceptions-64s.S:729: Error: operand out of range
>> (0x000000000000814c is not between 0xffffffffffff8000 and 0x0000000000007ffc)
>>
>> with powerpc:defconfig, powerpc:allmodconfig, powerpc:cell_defconfig, and
>> powerpc:maple_defconfig.
>>
>> This is on top of v3.15-rc5. Any idea what is going on ?
>>
>> Compiler is powerpc64-poky-linux-gcc (GCC) 4.7.2 (from poky 1.4.0-1).
>
> Interesting... works with all my test configs using 4.7.3...
>
> I don't have my tree at hand right now, I'll check what that means
> tomorrow see if I can find a workaround.
>

Maybe something is wrong with my toolchain. I'll try to find a more recent one.

Guenter
