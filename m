Message-Id: <se81d39f.013@amx.com>
Date: Wed, 26 Mar 2003 16:21:25 -0600
From: "Chuck Partridge" <Chuck_Partridge@amx.com>
To: <Dmitriy.Zavin@infineon.com>
Cc: "<" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: SCC2 and SCC3 serial ports on RPX Classic (MPC860)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Is this string sent by a program loaded via insmod and busybox?

I had a problem with drivers loaded as modules when using busybox.  The wrong strings would be sent when I did printk.  It drove me nuts for days.  I installed the true version of insmod and all worked fine.

Maybe it helps,

Chuck

>>> <Dmitriy.Zavin@infineon.com> 03/26/03 04:11PM >>>

Wolfgang,

What I mean by "not random" is this:
I write a string to /dev/tts/1, which will cause another string to be printed on the remote console. If I repeat this 50 times, the same messed up string will appear.

Thanks.

I hope that answers the question.

--Dima

>In message
><FD90897E35ABD311AE0E0008C7E6404A07192EDE@ca02exch4.sjc.infineo
>n.com> you wrote:
>>
>> I compiled the 2.4.7 kernel (from TimeSYS) with SCC2 and
>SCC3 enabled for IO. I have a break-out board where I manually
>hook into the TXD/RXD/GND pins (Port A, pins 12/13). Now, I'm
>sending a pattern (FOOOOOO) from the SBC to /dev/tts/1 (SCC2) which is
>> connected to a windows box on COM1. All I get on COM1 is
>garbage. But its not random. I made sure to set all the
>baud/stop bits/parity manually through IOCTL calls to make
>sure its right, but still no go. And SCC3 (/dev/tts/2) is
>completely unresponsive
>
>What exactly do you mean with "garbage, but not completely random"?
>
>Is it the ordinary type of "line noise" as you get when the baud rate
>is wrong, or do you get  valid  characters,  but  only  every  second
>character  gets  output?  If  you  get  every  second character, this
>usually means that your console port is misconfigured.
>
>Best regards,
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
>Always try to do things in chronological order; it's  less  confusing
>that way.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
