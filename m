To: Miku Jha <jha_miku@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc440 and i2c 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 17 Nov 2003 23:18:29 PST."
             <20031118071829.43116.qmail@web40301.mail.yahoo.com>
Date: Tue, 18 Nov 2003 09:09:02 +0100
Message-Id: <20031118080907.7438BC5F59@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20031118071829.43116.qmail@web40301.mail.yahoo.com> you wrote:
>
> I am running ppc440 with linux kernel version 2.4

Grrrghh...  You  sent  the  same  message   twice   to   the   (dead)
PPCBoot-Users   list   and   another   time  to  linuxppc-embedded???
Grrrrghhh!!!! Please fix your posting habits.

> >From the i2c bus trace it looks like in this
> situation ppc440 keeps issuing the clock pulses
> until the data line SDL is released by the slave
> but following that the SCL line is held low
> by ppc440 and is never released or set to IDLE?
>
> Is this the expected behaviour if the SDL is held
> low when the ppc440 comes up.

This is an expected and documented problem. See "doc/I2C_Edge_Conditions" in
the U-Boot / PPCBoot sources.

> Is there anyway I can fix this in the ppcboot code.

Yes. You could back-port the fixes that  went  into  U-Boot.  But  it
probably makes more sense to switch to U-Boot instead.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A meeting is an event at which the minutes are kept and the hours are
lost.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
