Date: Mon, 8 Jan 2001 07:55:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: michdaen@iiic.ethz.ch
Cc: Tony Mantler <nicoya@apia.dhs.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] drivers/macintosh/Config.in
Message-ID: <20010108075544.E19404@opus.bloom.county>
References: <20010106171733.M556@opus.bloom.county> <v04003a08b67ddaff44fe@[24.70.162.12]> <20010107173805.B19404@opus.bloom.county> <3A598EB5.638622B6@relog.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A598EB5.638622B6@relog.ch>; from daenzer@relog.ch on Mon, Jan 08, 2001 at 10:56:05AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 08, 2001 at 10:56:05AM +0100, Michel D?nzer wrote:
> Tom Rini wrote:
>
> > I also (may) move things like MOL into that file.
>
> We're still hoping to get MOL working on APUS anytime soon, and according to
> the web page it should work on PReP and CHRP boxen.

Well, there's no distinction between PReP, CHRP and Pmac, config wise.  It would
be in if [ "$CONFIG_6xx" = "y" ]; then ... fi probably (I need to ask one of
the IBM folks if it would work on POWER3).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
