To: "Leiying Du" <ldu@solectek.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Single-Step Debugger for HP probe 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 19 Mar 2002 15:03:09 PST."
             <004301c1cf9a$3cac90e0$6649a8c0@LEIYINGDU>
Date: Wed, 20 Mar 2002 00:27:21 +0100
Message-Id: <20020319232726.464D2109F3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <004301c1cf9a$3cac90e0$6649a8c0@LEIYINGDU> you wrote:
>
>   Does anyone have experience using WindRiver's Single debugger to debuge a
> linux zimage file? I can load the .elf file but it will crash at somewhere
> when the kernel is booting. Thanks.

>From what I've heard, there is no MMU support in their tools.

You will not have fun with Linux, then.

There is a good reason why everybody else uses a BDI2000 :-)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The only person who always got his work done by Friday
                                                 was Robinson Crusoe.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
