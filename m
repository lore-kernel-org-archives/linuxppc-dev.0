To: "svacca@valcom.com" <svacca@valcom.com>
Cc: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Unbuffered char reads from App from stdin (keyboard) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 15 Feb 2002 10:09:52 EST."
             <01C1B608.E92871A0.svacca@valcom.com>
Date: Fri, 15 Feb 2002 16:31:20 +0100
Message-Id: <20020215153125.C40B410E4C@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <01C1B608.E92871A0.svacca@valcom.com> you wrote:
>
> App and Linux kernel 2.2.13 running on mpc860T.
>
> I would like to know the best way, from inside my GNU C App,
> to sense if there's a keyboard key pressed.  Something

man select

man termios (search for VMIN and VTIME)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
See us @ Embedded Systems Nuremberg, Feb 19-21, Hall 12 K01 (with TQ)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
