Date: Wed, 24 May 2000 13:12:38 +0100
Subject: Re: memory pb on Pismo... rumors or reality...
From: Mark Steer <mark@insanely-great.co.uk>
To: <daenzerm@student.ethz.ch>, Francois Felix Ingrand <felix@ingrand.net>
CC: <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B55185C5.22F6%mark@insanely-great.co.uk>
In-Reply-To: <392BBEE3.B0091F67@relog.ch>
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


on 24/5/2000 12:37 pm, Michel Dänzer at daenzer@relog.ch wrote:

>>>> I plan to add some mem to my pismo (64->192)... should I fear Linux
>>>> crashs?
>>>
>>> I've experienced a hard lockup on Sunday running a self-compiled 2.2.15
>>> (rsync'd on Sunday from pmac-stable) on my 400 Mhz Pismo with 64 MB RAM.
>>> The
>>
>> But this is not related to the memory pb... as you have 64 meg only. My
>> question was more about the risk of "numerous" chrashes on a machine with 2
>> memory banks. (as this was reported here a while ago).
>
> AFAIR the cause for the lockups hasn't been determined yet, and I'm a counter
> example for the theory that it's caused by certain memory configurations.
Just to add my experience with Linux on the Firewire PB, I've upgraded to
192MB(64MB lower slot, 128MB top).  The Apple supplied 64MB shows in Apple
System Profiler as being the slower PC100-322 against the upgrade's 222.

The kernel is 2.2.15 and the machine has been completely stable.  I tend to
hammer this machine quite hard, compilations and heavy network activity
(through 100BT switch) all with no problems so far.
It seems to be at least as stable as the other machines I run LinuxPPC on -
i.e. completely :-)

Now all I have to do is get Airport running under Linux, and I'll be
extremely happy.

Regards,
       Mark.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
