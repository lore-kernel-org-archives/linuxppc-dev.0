To: cjohnson@gcctech.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Tools question 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 24 Nov 2003 13:32:17 EST."
             <3FC24EB1.60106@gcctech.com>
Date: Mon, 24 Nov 2003 20:14:03 +0100
Message-Id: <20031124191408.C662EC5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Chris,

in message <3FC24EB1.60106@gcctech.com> you wrote:
>
> 1. Do I really need to go back and build my own tool chain?  I've tried

Yes, you do - at least if  you  want  to  make  sure  you  completely
understand the technology and that you will in all situations be able
to build your tools from scratch.

> 2. On my intel development machine I see that libresolv.a comes from
> glibc-devel-2.2.5-34.  I have gcc-2.96-110 for my compiler.  Should I go
> find a version of glibc-devel that matches up with my existing 2.95.3
> tools?  How will I know if its the right version?

If you stick with your existing toolchain you must find a version  of
glibc-devel  that  matches your glibc. The compiler version is not so
much interesting here.

> 3. Better yet, is there somewhere I can just obtain a reasonable tool
> chain that's ready-built for my target machine?  Complete with libraries?

Did you ever have a look at our ELDK? It's free for download,  and  a
lot  of projects seem to be using it (and of course we use it ourself
for a couple of projects, too).

Please see http://www.denx.de/twiki/bin/view/DULG/ELDK for details.

> Sorry for the newbie type questions.  I have the "Using and Porting GNU
> CC" book, but am finding it a little too Stallman-esque to follow.  Anyone?

Karim Yaghmour: "Building Embedded  Linux  Systems"  [Paperback:  400
pages,  O'Reilly  &  Associates;  (May  2003);  ISBN  059600222X]  is
definitely worth reading.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"This isn't brain surgery; it's just television."   - David Letterman

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
