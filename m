Date: Sun, 6 Feb 2000 04:14:28 -0700 (MST)
From: Tom Rini <trini@kernel.crashing.org>
To: Brad Midgley <brad@turbolinux.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CPiA usb camera
In-Reply-To: <Pine.LNX.4.20.0002060154500.16011-100000@mail.turbolinux.com>
Message-ID: <Pine.LNX.4.10.10002060413260.784-100000@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 6 Feb 2000, Brad Midgley wrote:

> this is using xawtv 2.43, rsync-paul kernel on a bronze pb.

Try using USB stack: http://gate.crashing.org/~trini/2.3.42-2.2.14.diff.gz
(or so, linked off the main page).  Note, you'll have to plug/unplug it
once for the root hubs to be happy....
---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
