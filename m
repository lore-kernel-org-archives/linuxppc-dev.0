Date: Fri, 14 Jul 2000 15:07:49 +0200 (MET DST)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Keycodes for the new input layer
In-Reply-To: <00071301293300.05612@enzo.bigblue.local>
Message-ID: <Pine.SOL.3.95.1000714145651.27416B-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 13 Jul 2000, Franz Sirl wrote:

> On Wed, 12 Jul 2000, Derek Homeier wrote:
>
> > Personally, I'd like something different for both, so they could be
> > independently bound to the mousebuttons. If one wanted to use it as
> > KP_Enter, it could probably still be bound in the console and xkb
> > keymaps? I've no idea for a name, though. I think with the older kernels
> > it was just NoKey (and couldn't be bound to any Key Symbol, but to the
> > mousebuttons). KEY_LINEFEED, perhaps?
> >
> >  Fn-RET = KEY_KPENTER
> >  _^ = KEY_KPENTER
> >   Fn-_^ = [something different]
> >
> > would probably also be o.k., though.
>
> How about the appended patch?
>
Excellent! Fn-RET also emulates Mouse-3 now, but I probably wouldn't have
any use for an additional generic KP_Enter anyway (hmm, I do use it, in
emacs, but I could use up any number of keys in emacs ;). My adb_buttons
kernel arg is working again like it is supposed to (I know it's deprecated
now, maybe I'll replace it with

echo 101 > /proc/sys/dev/mac_hid/mouse_button2_keycode
echo  96 > /proc/sys/dev/mac_hid/mouse_button3_keycode

in /etc/rc.d/rc.local or wherever).

Thanks,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
