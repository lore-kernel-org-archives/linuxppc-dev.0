To: Scott Howard <scott@sthoward.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EST SBC8260 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 22 Mar 2001 12:32:04 PST."
             <3ABA6144.CF8D07C1@sthoward.com>
Date: Thu, 22 Mar 2001 22:38:59 +0100
Message-Id: <20010322213904.094EB281DC@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3ABA6144.CF8D07C1@sthoward.com> you wrote:
>
...
> The last detail is that the kernel uses a value for the IMMR register
> that is different from that set up by visionWare, and it loads at
> address 0 which is protected by the visionWare monitor; so some minor
> mods are necessary to the boot code to load at some other address,
> re-write the IMMR, relocate to zero and then continue with the remainder
> of the boot process.

This still seems a long way to go when you can just  install  PPCBoot
and have full Linux support.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Were there fewer fools, knaves would starve.              - Anonymous

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
