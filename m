Date: Fri, 3 Sep 1999 23:33:12 -0700 (MST)
From: Tom Rini <trini@kernel.crashing.org>
To: jeramy b smith <ultrapenguin@netscape.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Possible Bug in XFree3.3.5
In-Reply-To: <19990904001345.11766.qmail@www0m.netaddress.usa.net>
Message-ID: <Pine.LNX.4.10.9909032331190.8429-100000@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 3 Sep 1999, jeramy b smith wrote:

> I downloaded the 3.3.5 rpms from Tom's directory and installed them. I have a
> 2meg ati rage IIc. Before upgrading the rpm, I was using vmode 18 and cmode 16
> and the same for my X resolution (1152x864@16bpp). However, trying to startx
> with this configuration would crash.

Well shoot.  I hadn't made an announcement yet for a reason (newer, -1a
locally :))

> Changing the depth in to 8bpp in XF86config solved this. I tried setting the
> the resolution to 800x600 and bumping the colors up to 16bpp. XFB initializes
> the accel code, reports the font and pixmap caches are disabled. Then I get
> the BBdebug message that it is setting up gnome support. I catch the signal
> 11. blackbox then tells me:
> 
> X Error of failed request:   16 Badlength (poly request too large or internal
> Xlib length error
> Major/minor opcode of failed request: 72 / 0
> Resource id in failed request: 0x8000014

Odd.  I wonder if all of this has to do w/ the 15/16 bit fix...  Hmm..

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
