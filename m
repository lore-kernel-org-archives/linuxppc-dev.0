Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3EA84246.9050101@catapult.com>
Date: Thu, 24 Apr 2003 16:00:06 -0400
From: "Kevin A. Sapp" <Kevin.Sapp@catapult.com>
MIME-Version: 1.0
To: emanuel stiebler <emu@ecubics.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Basic Config file
References: <5.1.0.14.2.20030424134156.036e1e80@falcon.si.com> <3EA826C0.8050509@mvista.com> <3EA828B8.1040604@catapult.com> <3EA82B56.3070808@ecubics.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Read the ELDK manual, however, did not see anything
on the kernel configuration and building it.  Went to
kernelnewbies for that...anywhere else I can go for
kernel configuration.

Unresolveds are:
va_to_pte and get_IMMR in traps.c
the get_IMMR seems to be 8xx specific.
va_to_pte is in several headers for asm code,
but grep of the source tree does not show any
implementations in *.[Sch]

Thanks
Kevin


emanuel stiebler wrote:

> Kevin A. Sapp wrote:
>
>>
>> Hello all,
>>
>> I recently downloaded and installed the ELDK under RedHat
>> 8 targeting a 74xx.  Everything went pretty smooth (Thanks
>> Wolfgang!).  I am utterly inexperienced at building the
>> kernel.  This is the first one.  I have everything compiling,
>> but getting various linker unresolves.
>
>
> Can you tell us more what unresolves you get ?
>
>> Can someone point me to or send a simple config file as an
>> example?  As few components as possible would be great.
>
>
> Try the defaults first.
> I assume you read the documentation, right ?
> ;-)
>
> cheers
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
