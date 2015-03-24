Return-Path: <alexinbeijing@gmail.com>
Received: from mail-wg0-x22f.google.com (mail-wg0-x22f.google.com
 [IPv6:2a00:1450:400c:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DF6B1A0332
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 06:50:03 +1100 (AEDT)
Received: by wgs2 with SMTP id 2so2787806wgs.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 12:50:00 -0700 (PDT)
Message-ID: <5511BFDF.6070309@gmail.com>
Date: Tue, 24 Mar 2015 21:49:51 +0200
From: Alex Dowad <alexinbeijing@gmail.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [23/32] powerpc: copy_thread(): rename 'arg' argument to
 'kthread_arg'
References: <20150319064519.6BEA814010F@ozlabs.org>	
 <550A794C.7020904@gmail.com> <1426809274.2581.0.camel@ellerman.id.au>
In-Reply-To: <1426809274.2581.0.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Vineeth Vijayan <vvijayan@mvista.com>, Anton Blanchard <anton@samba.org>,
 Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20/03/15 01:54, Michael Ellerman wrote:
> On Thu, 2015-03-19 at 09:22 +0200, Alex Dowad wrote:
>> On 19/03/15 08:45, Michael Ellerman wrote:
>>> On Fri, 2015-13-03 at 18:14:46 UTC, Alex Dowad wrote:
>>>> The 'arg' argument to copy_thread() is only ever used when forking a new
>>>> kernel thread. Hence, rename it to 'kthread_arg' for clarity (and consistency
>>>> with do_fork() and other arch-specific implementations of copy_thread()).
>>>    
>>> I don't understand the bit about consistency with do_fork() ?
>>>
>> This series of patches includes one patch which renames the arg for
>> do_fork(), and others which rename the same arg for each arch-specific
>> implementation of copy_thread(). So if all of them are accepted and
>> merged, then all will be consistent. If only some of the patches are
>> accepted, I will rewrite the commit message so it doesn't mention
>> "consistency".
> Ah OK, I only got patch 23, so I missed the context of the whole series.
>
> I'll apply this one to the powerpc tree.
>
Dear M. Ellerman, sorry for not replying promptly. If you would like to 
apply this directly to the powerpc tree, that is fine, but can I edit 
the commit message to remove the mention of 'consistency'? I doubt that 
all 30+ archs will ever merge this change. Thanks, Alex
