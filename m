Message-ID: <3CCB75EE.1080208@pacbell.net>
Date: Sat, 27 Apr 2002 21:09:18 -0700
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: andrew may <acmay@acmay.homeip.net>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] IBM ocp I2C
References: <20020423200127.G20394@ecam.san.rr.com> <3CC9BD30.7050002@pacbell.net> <20020426203505.A1819@ecam.san.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


andrew may wrote:
> On Fri, Apr 26, 2002 at 01:48:48PM -0700, Armin wrote:
>
>>>In this patch I dump getown and getclock because they aren't
>>>used and I am sure there is a better way to do things.
>>>
>>this does not work on Walnut since "procfreq" is not part of openbios
>>and the PLLMR does not exsist on the stb03 or 03  so this changes wont
>>go in.
>>
>
> I don't have a stb03 or even know what chip it uses, so I have
> no idea what to do about it. We should have some generic 4xx
> functions to get the CPU/PLB/OPB clocks so we can calculate what
> the I2C div should be. We could always try trusing what the BIOS
> sets the divider to as well.
>
>
>
Andrew,


I agree, the issue I have is that the clock solution was too arch/bios
specific and should reside somewhere outside the driver in the form of a
fuction or variable (as you suggest) that can take into accout the
differences in arch and possibly bios.

Thanks

armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
