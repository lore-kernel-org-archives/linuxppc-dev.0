Message-ID: <3C4EC2A7.282CB112@lvl7.com>
Date: Wed, 23 Jan 2002 09:03:19 -0500
From: "John W. Linville" <linville@lvl7.com>
MIME-Version: 1.0
To: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BDI2000 breakpoints in dynamically loaded modules
References: <B164B53F5BD6D511888D009027732E1A024A20@ntserver.act.domain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Just a guess...when you do the "add-symbol-file", do you specify the
address for the .text (and possibly other) section(s)?  If you don't,
I'm not sure what it will default to be, but it will almost certainly be
wrong.

When you do the insmod, use the -m parameter and redirect the output to
the file.  Near the top of that file it will tell you where the .text
section starts.

Good luck!

John

Rudolf Ladyzhenskii wrote:
>
> Hi, all
>
> I am using BDI2000 to debug dynamically loaded module under Linux. When I
> put a breakpoint, it never goes off, but code does execute.
>
> At the moment the only 8260 board we have is used 100% of the time, so I do
> not have much chance to do any investigation.
> I'll describe what I do, may be this will help.
>
> I load the moule under Linux and then use "add-symbol-file" command. This
> allows me to view the source of my module. Then I put a breakpoint either
> through IDE (DDD) or from GDB prompt. Breakpoint appears in DDD, but never
> goes off. All memory translation is working.
>
> I can not remember if it worked before, I only briefly tried modules while
> ago. I recently upgraded DDD and BDI2000 firmware to the latest versions.
> May be this caused it?
>
> Any ideas are appreciated.,
>
> Thanks,
>
> Rudolf
>

--
John W. Linville
LVL7 Systems, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
