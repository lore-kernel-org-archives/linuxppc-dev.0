Date: Thu, 27 Jul 2000 14:42:37 -0700 (PDT)
From: Matt Brubeck <mbrubeck@hmc.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: iMac DV monitor sleep
In-Reply-To: <20000727205819.18500@192.168.1.10>
Message-ID: <Pine.GSO.4.21.0007271433140.16661-100000@turing.cs.hmc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 27 Jul 2000, Benjamin Herrenschmidt wrote:

> Being able to sleep, certainly. Soon, I can't tell. I've not yet
> figure out the details of the sleep process on those machines.

On a related note, does anyone know about standby modes for the monitors
on slot-loading iMacs? The internal monitor doesn't respond to standard
blanking signals, though an external display hooked up to the same video
port will blank just fine. Some of the vesa blanking modes cause the
internal display to turn solid red or yellow.

In MacOS the monitor will shut off only when the computer is put to sleep
(unlike the earlier iMacs, where the screen could power down separately).
Is this a limitation of the hardware, or is there some way to make the
internal monitor shut down while the rest of the machine stays awake? I
want to use my iMac as a server, but not as a space heater.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
