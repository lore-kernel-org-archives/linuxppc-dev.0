Date: Thu, 18 May 2000 17:14:27 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Mike Hudson <Exoray@isys.ca>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: BMAC+ & Full Duplex
In-Reply-To: <003401bfc10f$d9cca180$d2d3470a@mike>
Message-ID: <Pine.A41.3.96LJ1.1b7.1000518170657.15274D-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 18 May 2000, Mike Hudson wrote:

[...no idea about bmac...]
> Also, anyone look at implementing 'server mode' on the macs? This is a
> nother reason I still use BootX, I can set server mode in MacOS first
> before switching to Linux. (Sever mode is Apple's way of rebooting if A
> C power lost, crucial if a UPS is used) I've done some background reasearch
> on doing this with the CUDA (Power Chip on Pre-G4 desktops), and I'd love
>  to discuss this with someone. Too bad this is a non-persistent software
> setting,
> on my PC it's nice little BIOS option which I can set and forget.

How does this "server mode" work on Mac OS?  I once wrote a little app to
manipulate "auto power on command" via CUDA, and, if the server mode is
just doing CUDA command every so often so that a machine will reboot
automatically, you might be able to use the app with cron.  Not sure.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
