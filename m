From: August Hoerandl <ahoerandl@gmx.at>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: power saving
Date: Thu, 10 May 2001 12:36:12 +0200
Content-Type: text/plain;
  charset="us-ascii"
References: <3AF638AC.659C8A1F@centurysys.co.jp> <3AF6FC60.D5FE49D9@mvista.com>
In-Reply-To: <3AF6FC60.D5FE49D9@mvista.com>
MIME-Version: 1.0
Message-Id: <01051012361202.02674@linuxhoe>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Monday 07 May 2001 09:49 pm, Dan Malek wrote:
> Tania Oka wrote:
> > I would like to reduce power consumption on a custom MPC855T board.
>
> This has been asked before, and you can read about it in mailing
> list archives.

checked this - found nothing very specific

> Basically, the MPC8xx processors have a dynamic power management
> system that doesn't gain much from just doing something in the idle()
> loop.  The majority of the power is consumed by peripherals.  If they
> are not enabled, they automatically power down.  All of the MPC8xx
> drivers "do the right thing" on open and close to power up/down
> peripherals.
>
> If you have some very low power standby requirement, you need to add
> lots of power management software to do things like power down/up
> any external peripherals on your board, put DRAM in autorefresh
> mode, shut down the clocks and put the processor into a deep sleep.

yes - thats what i would like to do ;-)

> You could look at some of the PowerMac power management code for
> design ideas.

could anyone be a little more specific to get me to the right files ?

Regards
Gustl

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
