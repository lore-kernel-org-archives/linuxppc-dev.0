Message-Id: <200010100043.CAA10090@denx.local.net>
To: clark@esteem.com
cc: ppcboot-users@lists.sourceforge.net, linuxppc-embedded@lists.linuxppc.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Ethernet Trouble 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 09 Oct 2000 17:02:39 PDT."
             <1.5.4.32.20001010000239.006b54d8@pop.esteem.com>
Date: Tue, 10 Oct 2000 02:43:27 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1.5.4.32.20001010000239.006b54d8@pop.esteem.com> Conn Clark wrote:
>
> >Either it can't find init, or it's a shared library problem, or  your
> >console device is missing, or ...
...
>         Right now I think that it can't talk to the console or init uses a
> function in ld.so.1 to spit a message to the console and is failing to load

So what is /dev/console on your system?

I know that it used to be  a  symlink  to  /dev/ttyS0  on  sme  older
systems,  which doesn't work any more. Make sure you have a character
device major 5 minor 1, i. e. something like that:

crw-r--r--   1 root     root       5,   1 Mar 22  2000 /dev/console


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
He'd been wrong, there _was_ a light at the end of the tunnel, and it
was a flamethrower.                         - Terry Pratchett, _Mort_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
