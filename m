Message-ID: <3BE2E1B1.4311A9B4@mvista.com>
Date: Fri, 02 Nov 2001 10:10:57 -0800
From: Scott Anderson <scott_anderson@mvista.com>
MIME-Version: 1.0
To: Joshua Horvath <Josh_Horvath-AJH051@email.mot.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Abatron BDI2000
References: <3BE2C1DB.8B975906@labs.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joshua Horvath wrote:
> From playing around with the Abatron unit, it seems the two biggest advantages
> are
>
> 1) MMU support
> 2) Can be used with a Linux based development pc
>
> Since we haven't had a problem bringing the kernel up on our boards, 1) isn't
> (currently) a big deal.  What we really need is to be able to debug loadable
> modules, which from what I've gathered is only possible with kgdb.  Is this
> assumption correct?

I have used an Abatron to debug loadable modules.  As far as gdb is
concerned, it only knows that it is talking to something that speaks
the gdbserver protocol.  Whether that is kgdb or an Abatron makes no
difference.

> We can flash our boards, download code, etc. and as I said, we've got the
> kernel running successfully.  So other than point 2) above, is there anything
> else I've missed that would provide a compelling reason to purchase these
> units?

Price?

    Scott Anderson
    scott_anderson@mvista.com   MontaVista Software Inc.
    (408)328-9214               1237 East Arques Ave.
    http://www.mvista.com       Sunnyvale, CA  94085

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
