Date: Tue, 2 Sep 2003 12:12:04 +0000
From: Gabriel Paubert <paubert@iram.es>
To: Frank Murphy <murphyf+linux-ppc@f-m.fm>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux kernel / USB keyboard scancode problems
Message-ID: <20030902121204.A28288@mrt-lx1.iram.es>
References: <200308231409.24503.murphyf+linux-ppc@f-m.fm> <200309011256.40807.murphyf+linux-ppc@f-m.fm> <20030901114602.A28710@mrt-lx1.iram.es> <200309011459.21786.murphyf+linux-ppc@f-m.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200309011459.21786.murphyf+linux-ppc@f-m.fm>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Sep 01, 2003 at 02:59:21PM +0200, Frank Murphy wrote:
>
> On Monday 01 September 2003 1:46, Gabriel Paubert wrote:
> > > Yeah, the keycode/scancode/keysym stuff is a twisty maze. I do have the
> > > hardware to test these changes, if you have a guess to what they should
> > > be.
> >
> > What keyboard(s) do you have ?
>
> I have an original iBook with its built-in US layout keyboard. I also have a
> "narrow" iMac US keyboard (F1-F12 and no Delete or Insert key). I also have
> access to a UK Apple Pro Keyboard. This is the one with the F13, F14, & F15
> keys.
>
> > I've only access to my Pismo now, and it obviously does not have the
> > F13-F15 keys. I shall be back in front on my G4 in a few days.
> >
> > I'd first need to know what "showkey -k" and "showkey -s" give for these
> > 3 keys on your keybord.
>
> In the order F13, F14, then F15, with showkey -k, I get 85, 115, and 119.
> With showkey -s, I get 0x55 0xd5, 0x73 0xf3, and 0x77 0xf7.

What? Exactly the same code for keycodes and scancodes?

(85=0x55, 115=0x73, 119=0x77)

	Gabriel

P.S: I'm going to be a lot less responsive the rest of the week, I'm
having a few free days right now after having worked all over the
week-end.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
