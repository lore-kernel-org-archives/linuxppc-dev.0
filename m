From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Message-Id: <199910111228.OAA06049@simul.biophys.uni-duesseldorf.de>
Subject: Re: ADB probing
In-Reply-To: <Pine.LNX.4.10.9910081604290.30742-100000@web1.turbolinux.com> from Brad Midgley at "Oct 8, 1999 04:07:41 pm"
To: brad@turbolinux.com (Brad Midgley)
Date: Mon, 11 Oct 1999 14:28:11 +0200 (CEST)
Cc: dgatwood@mvista.com, bh40@calva.net, linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> How does all this discussion fit in with the work being done on the input
> system which will allow multiple independent keyboards, etc.?

Huh? What work is being done there? Kernel level or user space? 

To use multiple independent keyboards at kernel level: register different 
handler functions for each. But what would you do with multiple keyboards at
kernel level? Attach one to each virtual console? 
The Linux keyboard driver is currently written for one single keyboard
(last time I checked), and it's going to be hard to change that. 

At user space level: just open the proper ADB minor device and read out the
keycodes. I've only done it with the mouse/trackpad but keyboard should work
the same. I'll send my patch to benh to merge with his work on the driver
first though.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
