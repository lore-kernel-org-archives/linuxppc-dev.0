To: =?gb2312?q?Dross=20Zhou?= <zjuzhou@yahoo.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Why system panic after sometimes? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 10 May 2002 17:58:21 +0800."
             <20020510095821.44488.qmail@web15005.mail.bjs.yahoo.com>
Date: Fri, 10 May 2002 13:37:20 +0200
Message-Id: <20020510113725.CF7FB1195C@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

in message <20020510095821.44488.qmail@web15005.mail.bjs.yahoo.com> you wrote:
>
> I am sorry i have not described clear.
> We use HardHat CDK1.2's cross compile.

This is pretty old, but should work for this purpose.

> We have not use USB driver yet, I have writed a driver
> for a MPEGI coder chip (operate it via data and
> address bus).I think my driver (just handle interrupts
> from chip) is safe and will not affect kernel

Well, I think the kernel version you are using  is  very  stable,  so
maybe it _is_ a problem in your driver?

> and i don't know how to decode backtrace?

See  Documentation/oops-tracing.txt  in  youir  LInux  kernel  source
directory; alternatively, look up the addresses / symbols manually in
the Systems.map file in your kernel directory.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You got to learn three things. What's  real,  what's  not  real,  and
what's the difference."           - Terry Pratchett, _Witches Abroad_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
