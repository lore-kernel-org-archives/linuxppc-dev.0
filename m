From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Derrik Pates <dpates@dsdk12.net>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.17-pre[12]-ben0 trees hang on unsuspend
Date: Sun, 2 Dec 2001 10:51:08 +0100
Message-Id: <20011202095108.3294@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.40.0112012136190.20456-100000@andromeda.dsdk12.net>
References: <Pine.LNX.4.40.0112012136190.20456-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I've been trying the latest rsync snaps from your kernel tree
>(particularly to fix the time-warp bug that pops up in 2.4.16-ben0), but
>I've discovered that these latest trees cause the iBook FireWire that I'm
>using to hang up when I try to bring the unit out of suspend mode. The
>"sleep" indicator stops pulsating, and the drive spins up - I can hear it
>- but it never wakes up. The backlight never comes on, and typing at the
>keyboard (into a root shell - I was at a console logged in as root when I
>suspended) has no effect, apparently indicating it's really gone.
>Rebooting into 2.4.16-ben0 and suspending still works as normal, so I know
>it's not hardware.
>
>One thing to note is that normally, when the system comes out of sleep,
>the "sleep" indicator below the display flashes one last time before
>coming up out of suspend - when using 2.4.17-pre[12]-ben0, I don't get
>that "last flash" when I press a key to wake the system.

Could be one of my sleep.S changes, let me check...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
