Date: Fri, 10 Sep 1999 11:46:06 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Martin Costabel <costabel@wanadoo.fr>
cc: Shaw Terwilliger <sterwill@io.nu>, Hugh Caley <hcaley@loomer.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Paul's devel branch on Lombard?
In-Reply-To: <37D838A4.B65C5AA3@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.9909101143540.23282-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 10 Sep 1999, Martin Costabel wrote:
> Shaw Terwilliger wrote:
> > Martin Costabel wrote:
> > > Kernel 2.3.16 is from cvs@openprojects, with 2 little patches to make it
> > > compile and to recognize my ethernet card. I'll reboot in a minute to
> > > try 2.3.17.
> > 
> > I tried 2.3.16 last week (from cvs from openprojects), and had similar
> > machine check problems on boot.  It _did_ seem to recognize all my
> > hardware (perhaps the BMAC did not work, but I couldn't tell, it wouldn't
> > stay up that long).
> > 
> > If I use the CVS kernel, will I _need_ 2.95, or will EGCS 1.1.2 work?
> 
> I think there is even some explicit warning somewhere that
> gcc-2.95-compiled kernels are bad for your health or something. If you
> ask Linus (or read Documentation/Changes), you are told to use
> gcc-2.7.2.3, no kidding.

Recommended compiler versions in Documentation/Changes apply to ia32 only.

> 2.3.17 is now running, although I had to recompile it once; make
> oldconfig had eaten my CONFIG_ADBMOUSE. Someone is playing games with
> the config options. In make menuconfig, the "APPLE DESKTOP MOUSE" is
> marked as "NEW". Mine doesn't look very new anymore :-)

Woops, didn't read thit that well. So please forgot about my former suggestion
to run `make oldconfig' :-)

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- SONY Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Phone +32-2-7248608 Fax +32-2-7242686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
