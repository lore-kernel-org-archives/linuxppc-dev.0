Date: Tue, 25 Apr 2000 19:22:09 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: "W. Taylor Holliday" <wtholliday@ucdavis.edu>
cc: daenzerm@student.ethz.ch, linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree 4.0 dual monitor on AGP G4
In-Reply-To: <3905650C.FBCBB453@ucdavis.edu>
Message-ID: <Pine.LNX.4.10.10004251920480.16641-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I specified the busID. According to /proc/pci, my AGP card is 0:16:0 and my PCI
> card is 1:3:0.
> The server hangs the system using both fbdev and r128. I'm running kernel
> 2.2.15pre19.

Any error messages about PCI resource conflicts in the X server log file?
In case the log isn't written completely, try XFree86 --probeonly.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
