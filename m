To: dnevil@snmc.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SMC Console not responding 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 15 Apr 2002 16:09:54 CDT."
             <1079.206.104.177.96.1018904994.squirrel@nevil.org>
Date: Tue, 16 Apr 2002 01:09:50 +0200
Message-Id: <20020415230955.7259911258@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1079.206.104.177.96.1018904994.squirrel@nevil.org> you wrote:
>
> I just finished porting Linux 2.4.18 to a custom MPC860-based board.
> Everything works fine except input to the console.
...
> Just to answer the obvious, I have performed the following:
...
> 3. cd /dev, ln -sfn ttyS0 console

This is your problem. Instead, run:

	mknod /dev/console c 5 1

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The one who says it cannot be done should never interrupt the one who
is doing it.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
