To: "hu" <hl76@263.net>
Cc: "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Software FPU Emulation 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 29 Jul 2004 16:37:48 +0800."
             <20040729083532.57B4F2F7B5@smtp.263.net>
Date: Thu, 29 Jul 2004 19:11:24 +0200
Message-Id: <20040729171129.8C544C109F@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20040729083532.57B4F2F7B5@smtp.263.net> you wrote:
>
> 1)environment
> Linux kernel 2.4.4-rthal5
> ppcboot 1.1.5
> MPC823 board

Alls these are pretty old versions. Did you  try  running  some  more
recent code?

> 2)I'm running a device driver which read data from touchpanel, sometimes
> I get message like that:
> Oops: Kernel Mode Software FPU Emulation, sig: 8

Maybe a bug in your driver?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Monday is an awful way to spend one seventh of your life.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
