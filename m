Message-Id: <200012031440.eB3Eedm28381@denx.local.net>
To: Dan Hopper <eusdbho@rtp.ericsson.se>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: trouble with FEC on MPC860T - FEC_INTERRUPT not going off? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 02 Dec 2000 19:44:40 EST."
             <20001202194440.A9761@slug.rtp.ericsson.se>
Date: Sun, 03 Dec 2000 15:40:39 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20001202194440.A9761@slug.rtp.ericsson.se> Dan Hopper wrote:
>
> > > FEC, and am now working on the kernel.  At the moment, I'm using the
> > > 2.4-2000-11-11 kernel from ftp.denx.de as a baseline, since it
> > This version of the kernel is derived from 2.4.0-test5 from July, 26.
>
> OK.  Is there a newer one that's also friendly to 860Ts?  Some
> others appeared somewhat different configuration-wise.  What base do
> you use?

We are using 2.4-2000-11-11 for customer  projects,  too  (there  are
some new extensions, but nothing "interesting").

I've started testing 2.4.0-test11 in-house.

> I did, and it seems to work great.  It negotiated a 100Mbps
> half-duplex after detecting the PHYs, and took off from there with
> NFS.  I did need to hook up the interrupt line from the 972, as you
> indicated.

Fine. Thank you very much for the confirmation.

> Next week, I guess I'll be doing a CVS merge from your latest
> ppcboot tree and see if I can get that FEC code to play.
>
> Thanks for your help!
> Dan

You are welcome.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Our management frequently gets lost in thought.   That's because it's
unfamiliar territory.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
