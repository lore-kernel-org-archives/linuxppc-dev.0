Date: Tue, 26 Nov 2002 17:42:49 -0600
From: Nicholas Riley <njriley@uiuc.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Promise 20267 can't recognize IDE device or freezes
Message-ID: <20021126234249.GB2805891@uiuc.edu>
References: <20021126222932.GA2805891@uiuc.edu> <1038351550.672.48.camel@zion> <20021126222932.GA2805891@uiuc.edu> <1038351587.655.52.camel@zion> <20021126222932.GA2805891@uiuc.edu> <1038351550.672.48.camel@zion> <20021126222932.GA2805891@uiuc.edu> <1038351473.655.45.camel@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1038351550.672.48.camel@zion> <1038351587.655.52.camel@zion> <1038351550.672.48.camel@zion> <1038351473.655.45.camel@zion>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Nov 26, 2002 at 11:57:53PM +0100, Benjamin Herrenschmidt wrote:
> Promise controllers are giving me headaches everyday...
>
> Currently, I have the 20270 of the Xserve working properly, the
> driver in my tree is a mix of the old driver and the one in alan's
> kernel (latest from Andre). But it still seem to not be quite right
> with all controllers.

I could send you a 20267 if that would be of any use, they're cheap...

> Do you have a way to prevent probing of ide1 ? (ide1=noprobe maybe)

Typing "ide1=noprobe" in the args field in BootX has no effect.  Nor
does "ide0=noprobe", the tape drive is still identified.

On Tue, Nov 26, 2002 at 11:59:10PM +0100, Benjamin Herrenschmidt wrote:

> Also, when you say it freeze, can you make sure you wait up to one
> minute ? I have a timeout in there that may trigger...

I waited almost 10 minutes and there was no change.

On Tue, Nov 26, 2002 at 11:59:47PM +0100, Benjamin Herrenschmidt wrote:
> Can you tell me more about that freeze too ?

As ide0 is probed, the tape drive makes noises like it does when the
machine is powered on.  About 0.5 second after the ide1 probe message
is displayed, the cursor stops flashing and the machine stops booting.

Thank you *so* much for your help.

--
=Nicholas Riley <njriley@uiuc.edu> | <http://www.uiuc.edu/ph/www/njriley>
        Pablo Research Group, Department of Computer Science and
  Medical Scholars Program, University of Illinois at Urbana-Champaign

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
