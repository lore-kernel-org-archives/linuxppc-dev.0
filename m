Date: Sat, 26 Apr 2003 01:00:29 +0200
Subject: Re: ibook2r2 & strange freeze.
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: "Linuxppc-Dev@Lists.      " "Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Brice Figureau <brice@tincell.com>
In-Reply-To: <1051293026.10345.13.camel@gaston>
Message-Id: <B575F872-7771-11D7-BD12-0003939D5F18@tincell.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


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
>
> Also, it would be helpful if you could go backward the kernel
> versions to point when the problem started. You could try
> 2.4.20-ben1. If it doesn't have the problem, then -ben5, etc...
> (do a dichotomy).
After several hours of kernel compiling (my ibook is not that fast
;-)), I found that the latest working patch is -ben8.
The first non working is then -ben9.
I can crash ben9 almost reproductibly and xmon is triggered if that can
help you (I didn't understand how to use the System.map with xmon to
decipher the stack trace, but I might send xmon output and my
System.map).
Note this might not be the same crash as ben10, because xmon is not
fired with this kernel, although it seems to crash at the early
beginning of rc.sysinit (I'm almost sure this is something about the
fonts).

I hope this will help you to find the problem.
I can do more test if you wants me to.
Just drop me a mail.

Many thanks,

Brice


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
