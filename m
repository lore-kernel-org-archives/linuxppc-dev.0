Date: Tue, 8 Jun 1999 12:31:24 -0700 (MST)
From: Matt Porter <mporter@phx.mcd.mot.com>
To: paubert@iram.es
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PReP boot options was Re: How to boot VME from HD?
In-Reply-To: <Pine.LNX.3.96.990608123717.26558A-100000@liberty.chnd1.az.home.com>
Message-ID: <Pine.LNX.3.96.990608122023.28505F-100000@fwrsl-11.phx.mcd.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> check twice before typing the return key since the wrong digit in the of0
> parameter may make one of your partitions unusable (to solve this we would
> need a MILO like loader, but I had no time to work on this, although
> prepboot might be a good starting point).

This is something I've been looking at off and on.  I think the best route
is to take quik and combine it with features from the integrated
bootloader and your preploader.  The current situation makes it tough to
offer a PReP distribution that smoothly installs since one needs to
rebuild the bootloader and link with the kernel just to change the default
root device and kernel parameters. :-/

> I have also considered the
> possibility of booting from ROM (flash the kernel into the 4 or 8Mb of
> PROM present on these boards), but not implemented it.

I have working code for this that requires an updated PPCBUG revision.
A PPCBUG release with support for RBing PReP images should be available
"RSN", but it's hard to say since the firmware group is rather loaded
these days.

--
Matt Porter				Motorola Computer Group
mporter@mcg.mot.com			Real Time Software Support


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
