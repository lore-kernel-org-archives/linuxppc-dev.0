Date: Fri, 9 Nov 2001 13:18:43 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	Daniel Berlin <dan@cgsoftware.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Help from Gurus on modes and timing and frame buffers needed!
In-Reply-To: <20011109014750.QFJJ10804.tomts19-srv.bellnexxia.net@there>
Message-ID: <Pine.LNX.4.33.0111091307451.1704-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Thu, 8 Nov 2001, Kevin B. Hendricks wrote:

> PIXEL_CLOCK = 10,800
> H_ACTIVE = 1280
> H_BLANK = 408
> V_ACTIVE = 1024
> V_BLANK = 42
> H_SYNC_OFF = 128
> H_SYNC_WIDTH = 112
> V_SYNC_OFF = 4
> V_SYNC_WIDTH = 3
> [..]
> But how are the  left_margin, right_margin, upper_margin, and lower_margin
> determined?

Let's see if I remember them correctly:

right/lower = sync_off
left/upper = blank-sync_off-sync_width

so that

left_margin = 168
right_margin = 128
upper_margin = 35
lower_margin = 4

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
