From: Frank Murphy <murphyf+linux-ppc@f-m.fm>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: Linux kernel / USB keyboard scancode problems
Date: Tue, 2 Sep 2003 17:59:12 +0200
Cc: linuxppc-dev@lists.linuxppc.org
References: <200308231409.24503.murphyf+linux-ppc@f-m.fm> <200309011459.21786.murphyf+linux-ppc@f-m.fm> <20030902121204.A28288@mrt-lx1.iram.es>
In-Reply-To: <20030902121204.A28288@mrt-lx1.iram.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309021759.13949.murphyf+linux-ppc@f-m.fm>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tuesday 02 September 2003 2:12, Gabriel Paubert wrote:
> On Mon, Sep 01, 2003 at 02:59:21PM +0200, Frank Murphy wrote:
> > On Monday 01 September 2003 1:46, Gabriel Paubert wrote:
> > > I've only access to my Pismo now, and it obviously does not have the
> > > F13-F15 keys. I shall be back in front on my G4 in a few days.
> > >
> > > I'd first need to know what "showkey -k" and "showkey -s" give for
> > > these 3 keys on your keybord.
> >
> > In the order F13, F14, then F15, with showkey -k, I get 85, 115, and 119.
> > With showkey -s, I get 0x55 0xd5, 0x73 0xf3, and 0x77 0xf7.
>
> What? Exactly the same code for keycodes and scancodes?
>
> (85=0x55, 115=0x73, 119=0x77)

Exactly the same. I just double-checked.

F13 =  85 / 0x55 0xd5
F14 = 115 /  0x73 0xf3
F15 = 119 / 0x77 0xf7

> P.S: I'm going to be a lot less responsive the rest of the week, I'm
> having a few free days right now after having worked all over the
> week-end.

Enjoy the time off.

Frank


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
