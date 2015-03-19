Return-Path: <alexinbeijing@gmail.com>
Received: from mail-wg0-x22e.google.com (mail-wg0-x22e.google.com
 [IPv6:2a00:1450:400c:c00::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC58B1A02CB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 18:23:03 +1100 (AEDT)
Received: by wggv3 with SMTP id v3so54566888wgg.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 00:23:00 -0700 (PDT)
Message-ID: <550A794C.7020904@gmail.com>
Date: Thu, 19 Mar 2015 09:22:52 +0200
From: Alex Dowad <alexinbeijing@gmail.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Subject: Re: [23/32] powerpc: copy_thread(): rename 'arg' argument to
 'kthread_arg'
References: <20150319064519.6BEA814010F@ozlabs.org>
In-Reply-To: <20150319064519.6BEA814010F@ozlabs.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: Michael Neuling <mikey@neuling.org>,
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


On 19/03/15 08:45, Michael Ellerman wrote:
> On Fri, 2015-13-03 at 18:14:46 UTC, Alex Dowad wrote:
>> The 'arg' argument to copy_thread() is only ever used when forking a new
>> kernel thread. Hence, rename it to 'kthread_arg' for clarity (and consistency
>> with do_fork() and other arch-specific implementations of copy_thread()).
>   
> I don't understand the bit about consistency with do_fork() ?
This series of patches includes one patch which renames the arg for 
do_fork(), and others which rename the same arg for each arch-specific 
implementation of copy_thread(). So if all of them are accepted and 
merged, then all will be consistent. If only some of the patches are 
accepted, I will rewrite the commit message so it doesn't mention 
"consistency".

Thanks! AD
>
> Otherwise it looks fine.
>
> cheers
