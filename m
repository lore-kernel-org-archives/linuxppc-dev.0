To: cjohnson@gcctech.com
Cc: Sergey Urvanov <abs@dts.ru>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: ioperm 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 27 Apr 2004 11:59:02 EDT."
             <408E8346.9070202@gcctech.com>
Date: Tue, 27 Apr 2004 18:44:00 +0200
Message-Id: <20040427164405.B19C9C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <408E8346.9070202@gcctech.com> you wrote:
>
> I've seen that also - if I remember correctly, it was an issue with the
> toolchain.  I don't use eldk however, I roll my own.  Check your include

I bet a few beer that this is not a toolchain issue.

> >I'm getting it while trying to compile  for a ppc405EP based board,
...
> >#define BASEPORT 0x378

That smells like x86 PC code. It cannot run on a PowerPC.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I've got a bad feeling about this.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
