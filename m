Date: Tue, 2 Apr 2002 21:30:17 +0100
Subject: Re: any problems with gcc 3.0/3.1 and compiling 2.4.18 on ppc?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v481)
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
	linuxppc-dev@lists.linuxppc.org
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
From: Andrew Bradley <andrew-bradley@ntlworld.com>
In-Reply-To: <200204022214.46035@enzo.bigblue.local>
Message-Id: <71B77C10-4678-11D6-8E25-0030654F879C@ntlworld.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello Franz,

It looks like only me that has this intermittent problem with GCC 3.x.
Building or using.
I have:-
	glibc-2.2.4-53
	binutils-2.11.90.0.29-14 and tried binutils-2.12

I was wondering whether I was the only one building GCC 3.x on apple
hardware.

What surprises me is that the  "gcc version 2.95.3 20010319 (2.95.4CVS +
prerelease/franzo/20010912)"
is stable enough to build a kernel but not gcc 3.x on my system.

Any tips on finding this intermittent problem I have with every GCC 3.x
on my 8500 ?

Regards
Andrew

On Tuesday, April 2, 2002, at 09:14  pm, Franz Sirl wrote:

>
> On Tuesday 02 April 2002 22:06, Chris Friesen wrote:
>> We're looking at moving to gcc 3.x for 2.4.18, and are trying to decide
>> what version to use.  It appears that there were some ppc-specific
>> fixes
>> that went in to 3.1, and I'm not sure if they were ported back to 3.0.
>>
>> Has anyone had any successes or failures using either of these
>> versions on
>> 2.4.18 on ppc?
>> Any gotchas?
>
> Both 3.0.4 and the upcoming 3.1 are fine for use with the current PPC
> 2.4
> kernels. There is only one known issue with inlined functions that take
> and
> return 64-bit values, these may lead to extreme stack usage. A fix for
> this
> might go into 3.1pre CVS during the next days.
> After this has been decided I'll upload gcc-3.1pre RPMS and announce
> them.
>
> Franz.
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
