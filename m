Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205])
 by lists.ozlabs.org (Postfix) with ESMTP id 19E3F1A0350
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 12:02:19 +1000 (EST)
Message-ID: <539FA1A1.6030502@roeck-us.net>
Date: Mon, 16 Jun 2014 19:02:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] powerpc: Fix build warning
References: <1402677499-28289-1-git-send-email-linux@roeck-us.net>
 <alpine.DEB.2.02.1406161824340.21018@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.02.1406161824340.21018@chino.kir.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/16/2014 06:25 PM, David Rientjes wrote:
> On Fri, 13 Jun 2014, Guenter Roeck wrote:
>
>> If compiled with W=1, the following warning is seen in powerpc builds.
>>
>> arch/powerpc/kernel/smp.c:750:18: warning:
>> 	type qualifiers ignored on function return type
>> static const int powerpc_smt_flags(void)
>>                   ^
>>
>> This is caused by a function returning 'const int', which doesn't
>> make sense to gcc. Drop 'const' to fix the problem.
>>
>> Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>
> Acked-by: David Rientjes <rientjes@google.com>
>
> Although it's strange you report this happening on line 750 in the
> changelog but the patch shows it differently.
>

In the latest kernel (v3.16-rc1) the function is at line 750.
It appears that I ran the build test on a later version than
the one I used to write the patch. Hope that is not a problem.

Guenter
