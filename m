To: vandana mehtani <vandana_mehtani@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: stuck up on FADS board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 28 May 2002 03:35:56 PDT."
             <20020528103556.81524.qmail@web12706.mail.yahoo.com>
Date: Tue, 28 May 2002 12:41:24 +0200
Message-Id: <20020528104129.38BE611973@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20020528103556.81524.qmail@web12706.mail.yahoo.com> you wrote:
>
> I am trying to  port linux on FADS board.

There is nothing to port. The FADS board  is  supported  out  of  the
"box". Umm, ifyour hardware is working, that is.

> can i use the DIAB compiler instead of the   GCC

Forget it. There are many, many GCC features deeply  built  into  the
Linux kernel.

Use GCC instead.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I wish Captain Vimes were here. He wouldn't have  known  what  to  do
either, but he's got a much better vocabulary to be baffled in.
                                 - Terry Pratchett, _Guards! Guards!_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
