Date: Sun, 21 Jan 2001 19:47:14 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.1p8:don't "mount" audio CDs
Message-ID: <20010121194713.C22549@altus.drgw.net>
References: <20010121092528.53BFBDBA71@atlas.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010121092528.53BFBDBA71@atlas.valhalla.net>; from iain@sandoe.co.uk on Sun, Jan 21, 2001 at 09:25:24AM +0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jan 21, 2001 at 09:25:24AM +0000, Iain Sandoe wrote:
>
> It seems that if you (accidentally) do:
>
> mount /dev/cdrom /mnt/cdrom  (with an audio CD in the tray)
>
> (because it happens to be in your command history & you forgot ;)
>
> it completely locks up the kernel.
>
> no oops, no SysRq, no <option> power, no switch console - three keys is the
> only way out.
>
> (so not much useful info really) more of a "don't do that"... although it
> seems a bit drastic for such an easy mistake.
>
> Iain.

I managed to do this with a debian-woody cd, of all things..
no chance to debug it yet.. :-/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
