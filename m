Message-ID: <408EACA5.8090005@gcctech.com>
Date: Tue, 27 Apr 2004 14:55:33 -0400
From: "Christopher R. Johnson" <cjohnson@gcctech.com>
Reply-To: cjohnson@gcctech.com
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: Sergey Urvanov <abs@dts.ru>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: ioperm
References: <20040427164405.B19C9C109F@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Normally I would agree, except that he's getting link errors with
ioperm, inb and outb - he's not even running the code.  As to whether
the code will work, you have an excellent point.  Maybe we're both
right, so beers all around!

Wolfgang Denk wrote:

>In message <408E8346.9070202@gcctech.com> you wrote:
>
>>I've seen that also - if I remember correctly, it was an issue with the
>>toolchain.  I don't use eldk however, I roll my own.  Check your include
>>
>
>I bet a few beer that this is not a toolchain issue.
>
>>>I'm getting it while trying to compile  for a ppc405EP based board,
>>>
>...
>
>>>#define BASEPORT 0x378
>>>
>
>That smells like x86 PC code. It cannot run on a PowerPC.
>
>
>Best regards,
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
>I've got a bad feeling about this.
>
>

--
Christopher R. Johnson
Principal Software Engineer
GCC Printers
(781)276-8763


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
