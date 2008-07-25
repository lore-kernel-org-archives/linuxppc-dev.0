Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 940CADE032
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 04:29:23 +1000 (EST)
Date: Fri, 25 Jul 2008 22:29:21 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: GPIO drivers, other patches?
Message-ID: <20080725182921.GA32361@polina.dev.rtsoft.ru>
References: <AB4393B8-8578-4AFA-B23A-048F86A9A24D@kernel.crashing.org>
	<20080715160048.GA31615@polina.dev.rtsoft.ru>
	<20080715174201.GA2231@polina.dev.rtsoft.ru>
	<20080725175410.GA12278@polina.dev.rtsoft.ru>
	<FC85A2C9-A382-4E26-8A0A-33CD324DB632@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <FC85A2C9-A382-4E26-8A0A-33CD324DB632@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 25, 2008 at 01:14:58PM -0500, Kumar Gala wrote:
>
> On Jul 25, 2008, at 12:54 PM, Anton Vorontsov wrote:
>
>> On Tue, Jul 15, 2008 at 09:42:01PM +0400, Anton Vorontsov wrote:
>>> On Tue, Jul 15, 2008 at 08:00:48PM +0400, Anton Vorontsov wrote:
>>>> On Tue, Jul 15, 2008 at 10:10:21AM -0500, Kumar Gala wrote:
>>>>> Anton,
>>>>>
>>>>> I think I've gotten most of the patches from you,
>>>>
>>>> Yes, much thanks!
>>>>
>>>>> but I know there are
>>>>> few I've lost.  Can you just repost any patches that aren't in my
>>>>> powerpc-next tree.
>>>
>>> While testing the tree in run-time found that this patch is missing:
>>>
>>> [PATCH 3/4] powerpc: rtc_cmos_setup: assign interrupts only if there 
>>> is i8259 PIC
>>> http://patchwork.ozlabs.org/linuxppc/patch?id=18915
>>>
>>> Without this patch rtc will fail to probe on MPC8610HPCD:
>>>
>>> rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
>>> rtc_cmos: probe of rtc_cmos failed with error -38
>>
>> Kumar, sorry for bothering you again... are there any open issues
>> with the patch, can we merge it?
>
> I'd like Ben to ack it.

Benjamin, could you please take a look at this patch?

[PATCH 3/4] powerpc: rtc_cmos_setup: assign interrupts only if there is i8259 PIC
http://patchwork.ozlabs.org/linuxppc/patch?id=18915

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
