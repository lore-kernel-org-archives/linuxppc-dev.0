Message-ID: <3E68FD3E.3070209@mvista.com>
Date: Fri, 07 Mar 2003 14:12:46 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Omanakuttan <omanakuttan@tataelxsi.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: installing ncurses for cross compiling
References: <3E68F912.7000602@tataelxsi.co.in>
In-Reply-To: <3E68F912.7000602@tataelxsi.co.in>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Omanakuttan wrote:
>
> Hi,
> I want to write some programs for our serial console using ncurses. I
> have written and tested the apps in i386, now I want to cross compile it.

> When i tried to include the /usr/include/ for ncurses, ppc-gcc issues
> warnings.

Never, NEVER do -I/usr/include.  You are attempting to tell the compiler to use
your HOST system's include files when building software for a target.  This is
an incorrect development practice.  You should be sure to use both headers and
libraries built for the appropriate target architecture.

> I downloaded ncurses-devel-5.2-12.ppc.rpm but rpm refuses to install it
> on i386 because it is not for the architecture. I did not try the
> --force option because of the conflicts.

This will not work.  The random RPM you have downloaded is for a host system,
and not a cross development system.  You may be able to play some games with it
to get the pieces you want out.. but it's still not the right answer as it was
built with a different compiler and may be linked to other random libraries.

> How shall I get ncurses-devel-5.2-12 for ppc and install it in i386?

You shouldn't.  The proper method is to build ncurses in a cross-development
environment and install the components into the appropriate directories.  (The
"appropriate directories" varies based on product and what you have built.)

--Mark

> Thanks and regards,
> Om.
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
