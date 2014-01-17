Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205]) by ozlabs.org (Postfix) with ESMTP id 18A832C008F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 14:22:16 +1100 (EST)
Message-ID: <52D8A057.4080202@roeck-us.net>
Date: Thu, 16 Jan 2014 19:15:35 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Kevin Hao <haokexin@gmail.com>
Subject: Re: Kernel stack overflows due to  "powerpc: Remove ksp_limit on
 ppc64" with v3.13-rc8 on ppc32 (P2020)
References: <20140116180532.GA1616@roeck-us.net>	
 <20140117022005.GA29880@pek-khao-d1.corp.ad.wrs.com>
 <1389927490.7406.10.camel@pasglop>
In-Reply-To: <1389927490.7406.10.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/16/2014 06:58 PM, Benjamin Herrenschmidt wrote:
> On Fri, 2014-01-17 at 10:20 +0800, Kevin Hao wrote:
>> On Thu, Jan 16, 2014 at 10:05:32AM -0800, Guenter Roeck wrote:
>>> Hi all,
>>>
>>> I am getting kernel stack overflows with v3.13-rc8 on a system with P2020 CPU.
>>> The kernel is patched for the target, but I don't think that is related.
>>> Stack overflows are in different areas, but always in calls from __do_softirq.
>>>
>>> Crashes happen reliably either during boot or if I put any kind of load
>>> onto the system.
>>
>> How about the following fix:
>
> Wow. I've been staring at that code for 15mn this morning and didn't
> spot it ! Nice catch :-)
>
Yes, great catch! That fixes the problem.

Tested-by: Guenter Roeck <linux@roeck-us.net>

I assume you or Kevin will take it from there ?

Thanks,
Guenter
