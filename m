To: Owen Green <owenjinggreen@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: gdbserver ppc8xx 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 27 Feb 2002 13:47:49 PST."
             <20020227214749.38142.qmail@web20110.mail.yahoo.com>
Date: Wed, 27 Feb 2002 23:03:41 +0100
Message-Id: <20020227220346.54347109E3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20020227214749.38142.qmail@web20110.mail.yahoo.com> you wrote:
>
> could anyone tell me where can I find a gdbserver that
> works with mpc8xx processor? Where can I find sources

Well, use the one that came with HHL-2.0?

> that compiles for 8xx?

gdb-5.1 sources?

> I have already tried with mvista HHL2.0 Journeyman
> edition but I got something like:
> #gdbserver :7777 /bin/test
> Process /bin/test created; pid = 48
> getprotobyname:Sucess.
> Exiting
> #
> What could be wrong? Any tip will be very appreciate.

What do you think getprotobyname() does? [Hint: man getprotobyname  -
pay  special  attention  to  the  FILES section]. Hint2: There may be
other  networ  related  files  missing  on  your  system,  too,  like
/etc/services, or /lib/libnss_*

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Veni, Vidi, VISA:
        I came, I saw, I did a little shopping.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
