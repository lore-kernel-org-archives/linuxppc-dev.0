To: Owen Green <owenjinggreen@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Remote Multithread debugging problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 20 Aug 2002 07:47:03 PDT."
             <20020820144703.16442.qmail@web20107.mail.yahoo.com>
Date: Tue, 20 Aug 2002 16:58:14 +0200
Message-Id: <20020820145819.D051410DF8@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Owen,

in message <20020820144703.16442.qmail@web20107.mail.yahoo.com> you wrote:
>
> I`m trying to debug a multi-threaded application using
> gdbserver on the remote/target side and I`m having
> some problems, the output I got is depicted below:

I'm not surprised. This is broken in most versions of GDB / gdbserver
floating around.

> I`m using gdbserver5.2.1 (I tried the one from HHL-2.0
> Journeyman and didn`t worked too) compiled by myself
> using Mvista HHL 2.0 tools and gdb 5.2.1 on my i386.
> Am I doing something wrong or remote thread debugging
> is not supported by gdb? I have read something about

Let's say the support is incomplete :-)

> problems with multi-thread application debugging but I
> thought that it may be OK at this time...
> Could someone explain to me what`s happening?

Check out our ELDK  (see  http://www.denx.de/ELDK);  it  contains  an
extended  /  bug  fixed  version  of  GDB  / gdbserver; remote target
debugging of MT applications was one of the areas where we spend some
work.

If you're just looking for the patches: these can be found on our FTP
server; the README including description of the test procedure is at
ftp://ftp.denx.de/pub/ppc/patches/README-GDB-MT-Support

Hope this helps.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
That's the thing about people who think  they  hate  computers.  What
they really hate is lousy programmers.
- Larry Niven and Jerry Pournelle in "Oath of Fealty"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
