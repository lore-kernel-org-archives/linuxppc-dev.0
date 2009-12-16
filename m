Return-Path: <xtfeng@gmail.com>
Received: from mail-px0-f188.google.com (mail-px0-f188.google.com
	[209.85.216.188]) by ozlabs.org (Postfix) with ESMTP id 77430B6F19
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 17:45:30 +1100 (EST)
Received: by pxi26 with SMTP id 26so534572pxi.17
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2009 22:45:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B288131.2050306@in.ibm.com>
References: <4B2224C7.1020908@in.ibm.com>
	<7b6bb4a50912152225p4f5dde13re83c439407c16eaf@mail.gmail.com>
	<4B288131.2050306@in.ibm.com>
Date: Wed, 16 Dec 2009 14:45:28 +0800
Message-ID: <7b6bb4a50912152245v61a7f1ebgb41f4857134f3476@mail.gmail.com>
Subject: Re: [Next] CPU Hotplug test failures on powerpc
From: Xiaotian Feng <xtfeng@gmail.com>
To: Sachin Sant <sachinp@in.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 16, 2009 at 2:41 PM, Sachin Sant <sachinp@in.ibm.com> wrote:
> Xiaotian Feng wrote:
>>
>> Does this testcase hotplug cpu 0 off?
>>
>
> No, i don't think so. It skips cpu0 during online/offline
> process.

Then how could this happen ? Looks like cpu 0 is offline ....
0:mon> <4>IRQ 17 affinity broken off cpu 0
<4>IRQ 18 affinity broken off cpu 0
<4>IRQ 19 affinity broken off cpu 0
<4>IRQ 264 affinity broken off cpu 0
<4>cpu 0 (hwid 0) Ready to die...
<7>clockevent: decrementer mult[83126e97] shift[32] cpu[0]


>
> thanks
> -Sachin
>
> --
>
> ---------------------------------
> Sachin Sant
> IBM Linux Technology Center
> India Systems and Technology Labs
> Bangalore, India
> ---------------------------------
>
>
