Date: Wed, 27 Sep 2000 20:17:02 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Olaf Hering <olh@suse.de>
cc: Jon Erick Ween <jween@som.llu.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Xfree86-4.0.1, Lombard, Mach64 driver, X-server Crash
In-Reply-To: <20000927194234.A2778@suse.de>
Message-ID: <Pine.LNX.4.10.10009272015410.27656-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > OK, I've switched from BootX to Yboot using a stable 2.2.17 kernel and the
> > most recent XF86-4.0.1 and ati driver sources I can find. I seem to get
> > different PCI assignments to the ATI chip on boot-up (looking at dmesg
> > compared with using BootX) but the X-server still doesn't detect the chip
> > with "startx" or "XFree86" and exits with a "device not found" and "no
> > screens" error. Any further suggestions?
>
> There is a Modes line in the screen section, use a generic mode.
> Don't specify a Modes section.

It's probably just some error in the device section (the server doesn't
complain about 'no valid modes found' but 'no device found'.

Need to see your XF86Config's device section.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
