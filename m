Date: Wed, 20 Sep 2000 15:34:16 +0300
From: Alex Shnitman <alexsh@hectic.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kgdb/Sandpoint -- patch & help needed
Message-ID: <20000920153415.A5494@hectic.net>
References: <alexsh@hectic.net> <7803.969334757@msa.cmst.csiro.au> <20000919193930.C1406@hectic.net> <39C7A4F3.133DF04D@mvista.com> <alexsh@hectic.net> <7803.969334757@msa.cmst.csiro.au> <20000919193930.C1406@hectic.net> <39C79BBF.5D34BD5E@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39C79BBF.5D34BD5E@mvista.com>; from dan@mvista.com on Tue, Sep 19, 2000 at 01:00:47PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Dan!

On Tue, Sep 19, 2000 at 01:00:47PM -0400, you wrote the following:

> > Right, but before calling setup_arch, it prints the linux kernel
> > banner! Here's the code:
>
> The kernel "prints" lots of stuff, and it all goes into a buffer,
> to emerge quite late in the boot process when the (serial)
> console port is initialized for real use by applications.

Ooh,, I didn't know that. Thanks.

> > And I don't see the banner. Did you see it when you encountered this?
>
> You should see a 20 character (or so) ASCII string of coded information
> appear on the serial port used for GDB.  The system stops at this
> point, waiting to hear from GDB (as you have already discovered).

Still no dice.. I started minicom on the second serial port, and it
doesn't show anything when I boot the kernel. I can't find any obvious
reason for that. Perhaps someone with a Sandpoint should try it out?


--
Alex Shnitman                            | http://www.debian.org
alexsh@hectic.net, alexsh@linux.org.il   +-----------------------
http://alexsh.hectic.net    UIN 188956    PGP key on web page
       E1 F2 7B 6C A0 31 80 28  63 B8 02 BA 65 C7 8B BA

For Sale: Parachute. Only used once, never opened, small stain.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
