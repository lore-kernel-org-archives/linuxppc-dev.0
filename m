From: Frank Murphy <murphyf+linux-ppc@f-m.fm>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: Linux kernel / USB keyboard scancode problems
Date: Mon, 1 Sep 2003 14:59:21 +0200
Cc: linuxppc-dev@lists.linuxppc.org
References: <200308231409.24503.murphyf+linux-ppc@f-m.fm> <200309011256.40807.murphyf+linux-ppc@f-m.fm> <20030901114602.A28710@mrt-lx1.iram.es>
In-Reply-To: <20030901114602.A28710@mrt-lx1.iram.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309011459.21786.murphyf+linux-ppc@f-m.fm>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Monday 01 September 2003 1:46, Gabriel Paubert wrote:
> > Yeah, the keycode/scancode/keysym stuff is a twisty maze. I do have the
> > hardware to test these changes, if you have a guess to what they should
> > be.
>
> What keyboard(s) do you have ?

I have an original iBook with its built-in US layout keyboard. I also have a
"narrow" iMac US keyboard (F1-F12 and no Delete or Insert key). I also have
access to a UK Apple Pro Keyboard. This is the one with the F13, F14, & F15
keys.

> I've only access to my Pismo now, and it obviously does not have the
> F13-F15 keys. I shall be back in front on my G4 in a few days.
>
> I'd first need to know what "showkey -k" and "showkey -s" give for these
> 3 keys on your keybord.

In the order F13, F14, then F15, with showkey -k, I get 85, 115, and 119.
With showkey -s, I get 0x55 0xd5, 0x73 0xf3, and 0x77 0xf7.

Frank


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
