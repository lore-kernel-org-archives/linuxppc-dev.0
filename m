To: rekha gvv <rekhagvvc@yahoo.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linker error 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 18 Nov 2002 04:38:19 PST."
             <20021118123819.75480.qmail@web8001.mail.in.yahoo.com>
Date: Mon, 18 Nov 2002 13:48:41 +0100
Message-Id: <20021118124846.26A5511767@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20021118123819.75480.qmail@web8001.mail.in.yahoo.com> you wrote:
>
> I am trying to compile the utilities from the SELF
> but it gives the error
> ----------------------------------------------------
> powerpc-linux-gcc -Wall -Os -fomit-frame-pointer
> -fno-builtin -o depmod depmod.o ../util/libutil.a
> ../obj/libobj.a -s
> /usr/local/powerpc-linux/bin/ld: cannot open crt1.o:
> No such file or directory
> collect2: ld returned 1 exit status
> make[1]: *** [depmod] Error 1
> -----------------------------------------------------
> can u please tell me how to get the crt1.o and also
> the ldscript files present in
> /usr/local/powerpc-linux/ldscripts.

I don't know where you got your tools from, but  obviously  they  are
broken.  You  can  download ready-to-use working tools for free - see
http://www.denx.de/re/ELDK.html


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"A great many people think they are thinking when they are merely re-
arranging their prejudices."                          - William James

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
