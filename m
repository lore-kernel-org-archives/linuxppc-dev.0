Message-ID: <3C827800.67CC4435@ne.mediaone.net>
Date: Sun, 03 Mar 2002 14:22:41 -0500
From: Michael Zucca <mzucca@ne.mediaone.net>
Reply-To: mrz5149@acm.org
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.4.18 and dmasound and rebooting
References: <3C7688D2.CD7E7565@ne.mediaone.net> <20020222183122.9042@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, I tried 2.4.18 from kernel.org on my PowerCenter 132 and the DMA
dead patch works. However, as a side note, it only seems to work if the
sound code is compiled into the kernel. The same code in a module does
not work and still causes the sound hang. As I recall, the way the
emergency buffer was allocated was critical to it functioning properly.
I usually compile in the sound driver so it's not a big deal for me but
it might be for other folks.

On another note, I've noticed that if I reboot my machine using shutdown
-r the machine will reboot to a gray screen and then just hang there. It
won't boot into MacOS. I've noticed that on 68k Macs, it is important to
map the ROMs back into memory before rebooting or the machine just hangs
around forever. Is it possible that we're not remapping stuff back to
its usual place before rebooting on OldWorld machines? This has been a
persistant problem for a long time on 2.4.

Thanks!

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
