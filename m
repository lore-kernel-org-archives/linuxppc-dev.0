Date: Mon, 06 Mar 2000 17:39:20 +0000
From: David Riley <happyoscar42@usa.net>
Subject: Re: serial module in 2.3.x?
To: toa@pop.agri.ch
Cc: Dev-Linux <linuxppc-dev@lists.linuxppc.org>
Reply-to: happyoscar42@usa.net
Message-id: <38C3ED41.A0B4D9E4@usa.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <38C3BE97.3DE053C9@pop.agri.ch> <38C42E7D.B537A3F0@pop.agri.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Andreas Tobler wrote:
>
> Some follow up,
>
> I hang in the procedure autoconfig from serial.c, I get out the msg.
> 'Testing ttysx'.
> this happens on a wallstreet & on a pm7200.
> It takes a lot of time to find out where, since each freeze needs about
> 10' to reboot (fsck)
>
> Thanks for any hint!!
>
> Andreas Tobler wrote:
> >
> > Hi,
> > has anybody seen the same? I'd like to include the serial.o module into
> > recent kernels (2.3.x). No luck, I always get a machine check. I'm not
> > sure where it is.
> > This happens up to 2.3.50-pre2. I suppose it has to do with the
> > SHARE_IRQ etc.
> > Any ideas?
>
> Andreas

Isn't serial.c for the Intel-compatible serial ports (like the 16550's
on most PC's)?  I think you might want macserial.c.  Back in my early
Linux days, I used to try to include "dumb" serial ports, but it always
crashed because I should have done "Powermac serial ports".  Did they
try to merge sources?

--
"Your mouse has been moved.  Windows 95 must be restarted for change to
take effect."

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
