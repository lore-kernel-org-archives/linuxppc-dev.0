In-Reply-To: <Pine.GSO.4.21.0003210126560.24640-100000@turing.cs.hmc.edu>
Date: Tue, 21 Mar 2000 11:54:10 +0100
To: Matt Brubeck <mbrubeck@hmc.edu>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: aty128fb patch on iMac DV
Message-Id: <20000321115410.011731@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 21, 2000, Matt Brubeck <mbrubeck@hmc.edu> wrote:

>Ahh. That explains the error message from fbcon. But in any case the
>framebuffer is having its own problems; the picture is half-sized and
>appears in psychedelic colors several times across the screen.

Can you try the kernel at

rsync -arvz linuxcare.com.au::linux-pmac-benh <destination>

And tell me if it works better ? It includes Kevin
_really_latest_changes_ and seems to work on an iMacDV I have here (but I
could only test the boot console, there's no linux install on this
machine and will never be).

Thanks !


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
