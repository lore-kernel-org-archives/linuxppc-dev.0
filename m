Date: Wed, 12 Jul 2000 14:59:03 +0200 (MET DST)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
Reply-To: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Keycodes for the new input layer
In-Reply-To: <4.3.2.7.2.20000712141931.00c70690@mail.lauterbach.com>
Message-ID: <Pine.SOL.3.95.1000712143953.21439H-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 12 Jul 2000, Franz Sirl wrote:

> >I may disagree with a lot of people, but this does not seem right to me.
> >On international keyboards you need Mode_switch for a lot of characters
> >(as you'll certainly know ;-), which is usually bound to AltGr on
PC-Hardware.
> >Under MacOS, this is effected by Option-Key combinations, so for a fully
> >MacOS-compatible keymap you need to have ALTGR bound to Option.
> >Also I feel that the purpose of the Meta or ALT(L) on Unix is more similar
> >to that of Cmd in MacOS, but that's rather my personal opinion.
> >Of course, things do not become simpler by the fact that optionL and
> >optionR are identical on most Mac keyboards. If it were possible to make
> >Fn-Opt generate ALTGR (or vice-versa), this would add some flexibility.
>
> The problem here is that newer Apple keyboards additionally label OptionL
> as ALT and 3rd party keyboards with an additional OptionR label it as
> ALTGR, which pretty much limits the correct choices :-(. Anyway, I'll put
> keymap .inc files into console-tools that let you easily change it (eg.
> option-left-as-alt.inc, command-leftright-as-altgr.inc, etc.).
>
I see. Which of these is equivalent to the old single Option key?

> > > Ah, that's good information, just one question, what does the _^ key do in
> > > MacOS? I mean what can I do with this key in MacOS? Is it a modifier? A
> > > prefix? does it print characters?
> > >
> >It does mostly, but not always, the same as the Return key on the main
> >keyboard. For some applications, it behaves differently. In the Finder,
> >e.g. hitting KP_Enter will let you edit the name of the selected file.
> >I think under MacOS, there's no difference between Fn-Return and the
> >dedicated _^ key on the PB keyboard, and the standard ADB keyboard only
> >has one KP_Enter anyway.
>
> OK, so you want:
> _^ = KEY_KPENTER
> Fn-_^ = KEY_KPENTER
> Fn-RET = KEY_KPENTER
>
> Or something different for Fn-_^?
>
Personally, I'd like something different for both, so they could be
independently bound to the mousebuttons. If one wanted to use it as
KP_Enter, it could probably still be bound in the console and xkb
keymaps? I've no idea for a name, though. I think with the older kernels
it was just NoKey (and couldn't be bound to any Key Symbol, but to the
mousebuttons). KEY_LINEFEED, perhaps?

 Fn-RET = KEY_KPENTER
 _^ = KEY_KPENTER
  Fn-_^ = [something different]

would probably also be o.k., though.
>
> >I had another problem with the new input layer I forgot to mention:
> >Though I selected /dev/mouse (-> inputs/mice) as input device and imps2
> >as protocol, the mouse does not work in mol in the console mode.
>
> Hmm, dunno about that, should be the same. Does it work if you kill gpm?
 >
Haven't tried that. The console mode doesn't work at the moment anyway,
because it tries to switch to 640x480 at the end of the startup, but
I doubt that's related to the mouse problem (that appears much earlier,
when the first extensions are loaded).

Thanks,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
