Date: Fri, 20 Oct 2000 11:18:43 +0300 (EET DST)
From: Topi Kanerva <tkanerva@ees2.oulu.fi>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ADB-Mouse
In-Reply-To: <Pine.OSF.4.02.10010190958400.3355-100000@ax1305.physik.uni-marburg.de>
Message-ID: <Pine.GSO.4.21.0010191518150.27486-100000@stekt6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 19 Oct 2000, Henning Loeser wrote:

>[snip]
>input0: Macintosh mouse button emulation
>[snip]

as a side note, I suppose you people know how the mouse button emulation
works. I couldn't make it work at any rate on my Pismo PowerBook...
I'm using benh's 2.2.17pre20 kernel, and the new input layer is configured
in the .config so according to my studies (in the mackeyb.c) the emulation
should work as it is, when you just put a '1' in the
/proc/sys/dev/mac_hid/mouse_button_emulation file... I experimented with
different keycodes but found out that none of them would make any
difference to the gpm.

guys, how exactly do you make it to work?

-topi


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
