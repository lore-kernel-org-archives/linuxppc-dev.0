Date: Tue, 21 Mar 2000 11:49:35 -0800 (PST)
From: Matt Brubeck <mbrubeck@hmc.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: aty128fb patch on iMac DV
In-Reply-To: <20000321115410.011731@mailhost.mipsys.com>
Message-ID: <Pine.GSO.4.21.0003211147040.29509-100000@turing.cs.hmc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 21 Mar 2000, Benjamin Herrenschmidt wrote:

>> Ahh. That explains the error message from fbcon. But in any case the
>> framebuffer is having its own problems; the picture is half-sized and
>> appears in psychedelic colors several times across the screen.

> Can you try the kernel at
>
> rsync -arvz linuxcare.com.au::linux-pmac-benh <destination>
>
> And tell me if it works better ? It includes Kevin
> _really_latest_changes_ and seems to work on an iMacDV I have here (but I
> could only test the boot console, there's no linux install on this
> machine and will never be).

No, sorry. The video still freaks out in any color depth greater than 8.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
