Date: Wed, 02 Apr 2003 15:39:21 +1200
From: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Subject: Re: Linux support for MPC859T processor
To: Mark Hatle <fray@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <3E8A5B69.1030601@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <3E8A4B70.7090607@tait.co.nz> <3E8A4EE1.8090205@mvista.com>
 <3E8A536A.8070506@tait.co.nz> <3E8A554A.2040700@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yes, we are ready to have a big pain with porting, and we know that
there is a risk which we are trying to reduce.
Would the MontaVista give some hands on, for example, how to an internal
RTC function on '860 represent in the kernel ('859 doesn't have RTC
func) and how it's affect the kernel and how it could be "removed" etc?
So, we at least would know what shall we look for.
Also could you please tell me how assembler on '860 different from '859?
Would this affect booting?

> Honestly, I don't know my guess is close to non to a small handful...
> But I am truely a novice when it comes to CPU/board bringup.. (I've
> assisted in it, but my expertise and history is in userspace
> development.)  The things that can take massive amounts of time on
> these new processors/boards are hardware bugs (cpu and board) as well
> as device drivers for new on chip devices.  I have seen more then one
> engineer going bald due to hardware bugs, especially a board that the
> customer said "But it runs VxWorks, why doesn't it run Linux?"...
>
>> Not a lot of our people experienced in PPC assembler (including myself).
>> Actually not a lot experienced with PPC at all.
>> Roughly, from your point of you, how major changes in the kernel
>> could be? Just your subjective opinion.
>>
>>> On userspace basis.. the 860 and the 859 are fully compatable.. The
>>> need for
>>> 859T changes may be in the kernel.  So anyone who sells/supports an
>>> 860 based
>>> system can support your needs for application level.  (That includes
>>> MontaVista.)
>>>
>>> The linux kernel of course is a different level of complexity.
>>>
>>>> We are trying to find a linux supplier who supports Motorola MPC859T
>>>> processor (actually it will be processor from Motorola but our custom
>>>> board).
>>>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
