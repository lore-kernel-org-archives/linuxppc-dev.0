Date: Fri, 25 Apr 2003 22:05:52 +0200
Subject: Re: ibook2r2 & strange freeze.
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: "Linuxppc-Dev@Lists.      " "Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Brice Figureau <brice@tincell.com>
In-Reply-To: <1051293026.10345.13.camel@gaston>
Message-Id: <50FA95A6-7759-11D7-A518-0003939D5F18@tincell.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Benjamin,

On Friday, April 25, 2003, at 07:50 PM, Benjamin Herrenschmidt wrote:
> On Fri, 2003-04-25 at 19:43, Benjamin Herrenschmidt wrote:
>>> By unstable I mean that the computer completely freeze during boot
>>> time,
>>> around the time rc.sysinit is launched. Unfortunately I'm rather new
>>> to
>>> linux kernel so I don't know how to provide more information on the
>>> crash (maybe should I configure the kernel with xmon ?).
>>> In a divide&conquer approach I found that the part of rc.sysinit
>>> which
>>> 'uploads' the console font to the font layer was triggering the
>>> crash.
>>
>> Can you try 2 things and let me know if one of them helps ?
>>
>>  - Compile without CPUFREQ support
>>  - Use video=radeon:noaccel on the command line to disable
>> acceleration
>>    on console
This produced the same hard freeze (I tried every combination of the
two things).

> Also, it would be helpful if you could go backward the kernel
> versions to point when the problem started. You could try
> 2.4.20-ben1. If it doesn't have the problem, then -ben5, etc...
> (do a dichotomy).
Unfortunately there seems to be only from ben3 to ben10 available on
your site.

And fortunately ben3 is *not* affected !
So the problem lies between 4 and 10. I guess my next kernel compile
will be 6.

I'll compile your other patches tomorrow and let you know at which
point it fails.

Many thanks,
Regards,

Brice


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
