To: rekha gvv <rekhagvvc@yahoo.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: glibc 2.2.3 undefined reference 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 04 Dec 2002 02:51:47 PST."
             <20021204105147.13636.qmail@web8007.mail.in.yahoo.com>
Date: Wed, 04 Dec 2002 12:45:32 +0100
Message-Id: <20021204114537.D97F6C614B@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20021204105147.13636.qmail@web8007.mail.in.yahoo.com> you wrote:
>
...
> and hence  used to get either illegal instruction or
> segmentation fault...when everi tried to run the
> application .theni read from the mailing list that
> glibc need to be compiled with the option
> "--without-fp"
> Now i have given the configure line as
> ./configure --host=powerpc-linux \
> > --enable-add-ons --with-headers=/kernel/include \
> > --without-fp
> CFLAGS="msoft-float -D_SOFT_FLOAT -mcpu=860"
>
> but still i end up with errors  at link time ....
...
> I really dont know how to move further ...any help
> fairly welcomed ....

You can either check the build scripts as used with  our  ELDK  -  or
just download the working tools. See http://www.denx.de/re/ELDK.html

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
When you die, the first thing you lose is your life. The  next  thing
is the illusions.                       - Terry Pratchett, _Pyramids_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
