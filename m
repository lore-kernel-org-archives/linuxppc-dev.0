From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Message-Id: <199910071216.OAA02617@simul.biophys.uni-duesseldorf.de>
Subject: Re: ADB probing
In-Reply-To: <37FC8268.E886EB87@tiac.net> from Timothy Wall at "Oct 7, 1999 07:22:15 am"
To: twall@tiac.net (Timothy Wall)
Date: Thu, 7 Oct 1999 14:16:21 +0200 (CEST)
Cc: trini@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I've been working on a tablet driver, and doing things essentially on the same
> level and providing /dev/adbtablet for application-level stuff.  Are there any
> docs or samples on what I can do through /dev/adb?

Numerous apps, such as mousehack or mousemode, the trackpad tool etc. And
the ultimate doc is drivers/macintosh/adb.c ... There's probably more; I
just use a Powerbook and happened to write the original adbmouse driver for
m68k. 
 
> The tablet driver has an ADB scan loop if you're interested.

I'd rather not poll the ADB bus if it can be avoided. How does MacOS detect
a new mouse device? But you could always force a bus reset and rescan via 
/dev/adb. 

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
