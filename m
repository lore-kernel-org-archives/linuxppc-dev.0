Date: Sun, 30 Jul 2000 00:41:45 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.0-test5 :-((((
In-Reply-To: <200007292137.WAA05449@hyperion.valhalla.net>
Message-ID: <Pine.LNX.4.10.10007300034580.3134-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> 1/
>
> When in "single" lower-case "a" doesn't work.  It's the only key AFAI can
> tell.
>
> Works OK once we get to init 5 and the Xserver is up (Xpmac rev 10).

Broken default keymap - lowercase a on Mac ADB keyboards is keycode 0
which is used for some special purpose internally in the keyboard driver.
Once some keytable gets loaded, the key should be remapped.

In that case it should also work if you boot into any other runlevel
without X.

Assuming you're talking about a Powermac with ADB keyboard, and the
keyboard driver still reserves keycode 0 for some ioctl purpose in 2.4.0 -
haven't looked at the code in a while (and I think I hacked keyboard_input
to remap 'a' to some unused keycode for m68k, but Paul might not have
accepted that patch for PPC).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
