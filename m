To: Jeff H Zhong <jeff@doremilabs.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: debugging using bdi2000, unable to proceed. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 18 Apr 2003 16:12:34 -0000."
             <3EA023F2.820B65C0@doremilabs.com>
Date: Sat, 19 Apr 2003 01:24:45 +0200
Message-Id: <20030418232450.A88C8C58B9@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3EA023F2.820B65C0@doremilabs.com> you wrote:
>
> We may need one more variable to be passed to kernel and let kernel know
> if we want initialize ethernet or not?

No, the Linux driver should always assume an uninitialized system and
perform the required steps himself.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It is necessary to have purpose.
	-- Alice #1, "I, Mudd", stardate 4513.3

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
