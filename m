Date: Wed, 31 Dec 2003 12:21:27 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Colin Leroy <colin@colino.net>
Cc: linuxppc-dev@lists.linuxppc.org,
	<debian-powerpc@lists.debian.org>
Subject: Re: Userland tool for mouse buttons emulation
In-Reply-To: <014f01c3cf82$81fc4e80$3cc8a8c0@ANOSP>
Message-ID: <Pine.LNX.4.44.0312311218290.21107-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I once submitted a patch about mouse button emulation, and BenH
> told me that this emulation shouldn't be done in the kernel but
> rather by a userland tool.
>
> I wrote a little mouseemu program to do that. It replaces the
> kernel emulation (be sure to
> echo 0 > /proc/sys/dev/mac_hid/mouse_button_emulation
> before testing it ;-)).

I'll give it a try. Any plans to package this yourself? I'd make it a
separate package otherwise - this should be useful for other archs as
well.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
