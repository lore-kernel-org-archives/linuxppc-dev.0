Date: Thu, 18 Oct 2001 10:24:04 -0700
Subject: Re: Compiling BootX?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v472)
Cc: Takashi Oe <toe@unlserve.unl.edu>,
	linuxppc-dev@lists.linuxppc.org
To: Andrew P McPherson <apm@MIT.EDU>
From: "David A. Gatwood" <dgatwood@apple.com>
In-Reply-To: <Pine.GSO.4.30L.0110172159300.16073-100000@biohazard-cafe.mit.edu>
Message-Id: <ED9543FC-C3EC-11D5-951D-003065B90BBC@apple.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wednesday, October 17, 2001, at 07:02 PM, Andrew P McPherson wrote:

>
> On Tue, 16 Oct 2001, Takashi Oe wrote:
>
>> On Sun, 14 Oct 2001 23:57:39 -0400 (EDT), Andrew P McPherson wrote:
>>
>>
>>> The problem with the MkLinux booter is that it refuses to run because
>>> it
>>> doesn't recognize the machine as "supported."  Is the source of the
>>> MkLinux booter available so that I could disable that "feature," or
>>> was
>>> that a closed-source effort by Apple?
>>
>> It's a closed-source software.  Is the one you have version 1.4?
>> What's the gestalt id of your machine with PPC card?  Have you tried
>> some software to fake the id (and change the type of apple booter from
>> 'scri' to 'INIT' or so)?
>>
>
> Thanks for the suggestion.  Installing the "Wish" extension to change
> the
> gestalt ID to a PowerMac 6100/60 worked.  I did need  to change the type
> to INIT because otherwise the booter always loaded before Wish.
>

I missed your hardware config.  What was it, again?  If it's a 68k mac
with a PPC card, you probably want to set it to the gestalt of a 5300.
The kernel should then identify that it isn't really a 5300 and should
half-heartedly attempt to boot anyway, then crash at some point.  Let me
know the gestalt, and I can verify whether the MkLinux booter knows it.
I can't promise that I'd be allowed to send you an update or anything,
but at least I can check and see if it knows the gestalt.  :-)


David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
