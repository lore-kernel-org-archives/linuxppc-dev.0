Date: Thu, 9 Nov 2000 09:14:02 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Jon Erick Ween <jween@som.llu.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.18pre18 kernel panic on Lombard
In-Reply-To: <773744E7737.AAA39B0@som.llu.edu>
Message-ID: <Pine.LNX.4.10.10011090906210.18340-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I'm trying to get my usb ports to work on my Lombard. I have 2.2.8pre17
> running OK but without USB or 3-button emulation working (in console or X).
> rsynced and compiled 2.2.18pre18 without problems but wind up in a kernel
> panic after loading the adb mouse handler and pty configuration (see
> below). Is this a problem with the new input layer (I don't seem to have
> /dev/input/) or a problem with the Lombard's usb ports?

Neither. I use a self compiled 2.2.18 and there's no such problem. At the
time where you see the panic, the kernel doesn't yet know about the root
filesystem, and consequently doesn't know about /dev/input/ either. What
sort of USB mouse are you using? Do you have both ADB mouse and USB HID
support configured?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
