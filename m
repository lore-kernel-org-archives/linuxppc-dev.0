Date: Sun, 6 Feb 2000 02:47:39 -0800 (PST)
From: Brad Midgley <brad@turbolinux.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: [xfree accel bug] Re: 24 bitplanes in X? (openh323 videoconf)
In-Reply-To: <Pine.LNX.4.20.0002060113280.15781-100000@mail.turbolinux.com>
Message-ID: <Pine.LNX.4.20.0002060245040.16369-100000@mail.turbolinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


i confirmed this is an accel bug in Xfree86-3.3.6. if i put options
"noaccel" in my xconfig, then the video is well-behaved, just slow.

On Sun, 6 Feb 2000, Brad Midgley wrote:

>
> is anyone having success with specifying 24 bitplanes in their xconfig?
>
> apparently this is the only way one can use openh323's videoconferencing
> but on my bronze powerbook, the screen is messed up (there are 4 mini
> duplicates of the main screen appearing at the top of the screen)
>
> i'm using xfree 3.3.6 (dev-rel-1.1), bootx, and rsync-benh.
>
> Brad
> brad@turbolinux.com | http://www.turbolinux.com/~brad/
>
>

Brad
brad@turbolinux.com | http://www.turbolinux.com/~brad/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
