Message-ID: <37D838A4.B65C5AA3@wanadoo.fr>
Date: Fri, 10 Sep 1999 00:45:56 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Shaw Terwilliger <sterwill@io.nu>
CC: Hugh Caley <hcaley@loomer.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Paul's devel branch on Lombard?
References: <37D74322.B787B9FE@loomer.com> <19990909092545.C4200@io.nu> <37D7C974.77E93281@loomer.com> <37D820B5.F84B223D@wanadoo.fr> <19990909163058.A22217@io.nu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Shaw Terwilliger wrote:
> 
> Martin Costabel wrote:
> > Kernel 2.3.16 is from cvs@openprojects, with 2 little patches to make it
> > compile and to recognize my ethernet card. I'll reboot in a minute to
> > try 2.3.17.
> 
> I tried 2.3.16 last week (from cvs from openprojects), and had similar
> machine check problems on boot.  It _did_ seem to recognize all my
> hardware (perhaps the BMAC did not work, but I couldn't tell, it wouldn't
> stay up that long).
> 
> If I use the CVS kernel, will I _need_ 2.95, or will EGCS 1.1.2 work?

I think there is even some explicit warning somewhere that
gcc-2.95-compiled kernels are bad for your health or something. If you
ask Linus (or read Documentation/Changes), you are told to use
gcc-2.7.2.3, no kidding.

2.3.17 is now running, although I had to recompile it once; make
oldconfig had eaten my CONFIG_ADBMOUSE. Someone is playing games with
the config options. In make menuconfig, the "APPLE DESKTOP MOUSE" is
marked as "NEW". Mine doesn't look very new anymore :-)

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
