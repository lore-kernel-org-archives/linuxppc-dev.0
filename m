Message-ID: <398540D2.78A1388E@relog.ch>
Date: Mon, 31 Jul 2000 11:03:14 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: SteffenH@hyperion-software.de
CC: Iain Sandoe <iain@sandoe.co.uk>, takashi oe <toe@unlserve.unl.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC X Server
References: <yam8247.1300.146578880@mail.lf-online.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Steffen Haeuser wrote:

> >agpgart was required _for r128 DRI_ until some time ago. It's possible that
> >it's still needed by the driver in X 4.0.1 but definitely not in the latest
> >DRI CVS.
>
> That is really good news :) If anyone had the chance to try it out, please
> tell so...

Hold on, I will :)


> if this works, we might even take some of you guys into the Sin Beta Tester
> programs, if I remember right, we still need a handful of testers (but I
> have to check with the guy doing the Betatester issues in our company...).

I for one wouldn't say no...


> Driver Coding normally has not that much to do with the OS... :)
> The main work is to find out how this Chip works, and then duplicate the
> functionality of an API by using the Chip Registers (and some of those
> sometimes do things in a *really cruel way*... some years ago I had to do
> some stuff on the old Virge chip...
> this was nasty...) The difficult is usually the register setup... not the
> interface to the OS...

AFAIK the specs for Rage128 aren't publicly available, but there's working
code in DRI - I'm convinced it will be far more easier to get it working than
write something new from scratch.


Michel


--
UNIX is like Sex:
If you don't know it, you don't miss it. But if you know it, you'll need it.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
