Message-ID: <3E8A554A.2040700@mvista.com>
Date: Tue, 01 Apr 2003 21:13:14 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux support for MPC859T processor
References: <3E8A4B70.7090607@tait.co.nz> <3E8A4EE1.8090205@mvista.com> <3E8A536A.8070506@tait.co.nz>
In-Reply-To: <3E8A536A.8070506@tait.co.nz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Honestly, I don't know my guess is close to non to a small handful...  But I am
truely a novice when it comes to CPU/board bringup.. (I've assisted in it, but
my expertise and history is in userspace development.)  The things that can take
massive amounts of time on these new processors/boards are hardware bugs (cpu
and board) as well as device drivers for new on chip devices.  I have seen more
then one engineer going bald due to hardware bugs, especially a board that the
customer said "But it runs VxWorks, why doesn't it run Linux?"...

--Mark

Dmytro Bablinyuk wrote:
> Not a lot of our people experienced in PPC assembler (including myself).
> Actually not a lot experienced with PPC at all.
> Roughly, from your point of you, how major changes in the kernel could
> be? Just your subjective opinion.
>
>> On userspace basis.. the 860 and the 859 are fully compatable.. The
>> need for
>> 859T changes may be in the kernel.  So anyone who sells/supports an
>> 860 based
>> system can support your needs for application level.  (That includes
>> MontaVista.)
>>
>> The linux kernel of course is a different level of complexity.
>>
>>> We are trying to find a linux supplier who supports Motorola MPC859T
>>> processor (actually it will be processor from Motorola but our custom
>>> board).
>>
>>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
