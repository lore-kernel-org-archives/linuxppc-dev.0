Date: Sun, 7 Oct 2001 18:49:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: still no luck with Radeon or Adaptec SCSI controller in 2.4.X
Message-ID: <20011007184922.A24315@cpe-24-221-152-185.az.sprintbbd.net>
References: <v03110700b7e6434b6153@[64.230.151.19]> <v03110701b7e646731f26@[64.230.148.35]> <20011007163351.C16260@cpe-24-221-152-185.az.sprintbbd.net> <20011008014159.MXEV19401.tomts15-srv.bellnexxia.net@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011008014159.MXEV19401.tomts15-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Oct 07, 2001 at 09:44:13PM -0400, Kevin B. Hendricks wrote:
> Hi,
>
> > You have to have the new driver off or as a module.
>
> Aha!  Thanks, I should have thought of that.  I recompiled with the old
> AIC-7XXX driver and now SCSI works like a charm!  No more wierd aborts.
>
> The new driver and my setup just don't get along.
>
> So with that fixed, I tried to get the network working but ran into
> trouble.
>
> - I missed loading the ipchains module since I was running ipchains on
> 2.2.19

IP Tables, and then ipchains compat. :)

> - I missed the fact that my two ethernet cards are now recognized in
> reverse order (eth1 is the internal BMAC+ when it was eth0 previously).

This is what modules are for. :)
/etc/modules.conf:
alias eth0 bmac
alias eth1 tulip  # or de4x5, since tulip is broken on some cards

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
