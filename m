Message-ID: <3AE20D7E.60A137C2@wanadoo.fr>
Date: Sun, 22 Apr 2001 00:45:18 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: XF4, SysRq, VT, mouse buttons, Keymaps and all that
References: <20010419143631.8A7F72EFC2@apollo.valhalla.net> <5.1.0.14.2.20010420115236.04112008@mail.lauterbach.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl wrote:

> Please stop this keyboard layout bashing! I'm a getting bored by your wrong
> patches on the lists.

Ouch. I guess I asked for this, having used some strong language myself.
If I have offended you, I am sorry.

But I am not quite sure what "patches" you are talking about. The only
keyboard-related things I remember having sent to the linuxppc lists in
the last couple of months were two tiny keymaps for the console and XF4,
respectively, that adapt the US keyboard on my iBook to my taste, and a
more or less complete XF4 keymap for French Macintosh keyboards that was
the first of its kind, AFAICT. I would not consider these as "patches",
but as legitimate user modifications of configuration files. I think I
even have occasionally tried to discourage people from patching the
Linux kernel or the XFree86 sources just for small modifications of the
keyboard layout. And I never sent these things out to preach to the
masses, but only to users that were, like me earlier, in a situation
where things just did not work.

What you can blame me for is having been too tired this week to pay
attention to which list I was answering. I shouldn't have written to the
dev list. But when even seasoned developers seem to have the same
keyboard problems as newbies... :-)

>                        You can blame Apple for labeling the OPT key with
> ALT, but that's it. Every linux doc talks about using ALT-CTRL-Fx for VT
> switching and that's how it works now.

Beyond questions of style and personal taste(*), I think there remains a
real problem. I am talking about the 2 keys labelled alt/option and
<Apple>/<Cloverleaf> on my iBook keyboard, using recent kernels and XF4.
Please correct me if I am wrong here, but I think the situation is as
follows:

The 2 keys produce in X the keycodes 64 and 115, respectively, and with
the standard macintosh/us symbols file, this results in the keysyms
"Alt_L" and "NoSymbol". The latter one is not very useful. There are a
couple of variants on this in the PC style symbol file collection, but
in NONE of the keymaps that come with XFree86 (in kfukui's excellent
precompiled version), is either one of these keys mapped to the keysym
"Mode_switch" that seems to be necessary in order to produce more than 2
symbols per key. The problem is that Apple keyboards don't have an AltGr
key that is used for this purpose on PC keyboards. Apple keyboards
traditionally use the alt key for this same purpose.

In the console, the situation is similar. The keycodes are 56 and 125,
and they are mapped to Alt and Decr_Console, respectively. This gives me
the possibility to switch consoles in two ways, either by pressing
alt-Fx or by repeatedly hitting the Apple key, but I don't get an AltGr
key.

> If you want to have it different, create a "XkbVariant SwitchOptCmd",
> "XkbVariant Powerbook" etc. and _submit_ it to the XFree86 project.

I am sorry, but I don't have enough time (or call me lazy if you prefer)
to lift myself to the level I consider necessary to act as an XFree
developer. I will remain on the level of a user who struggles to get
things working so that he can use them for his daily work.

> If you are too lazy to fix it correctly, that's ok, but keep your hacks
> private and stay off the lists with wrong patches (that will break on every
> upgrade) that just confuse people.

Time permitting, I think I shall continue to offer help to fellow Linux
users. From the feedback I got so far, I do not get the impression that
I confused anyone who wasn't much more confused before. I made it always
clear that these were just "my private hacks". And I just upgraded a few
minutes ago to XFree86-4.0.99.3-0a (thanks Kaoru!) without any problem
and without breaking my "patches", thank you.

--
Martin

(*) I don't care which key is used to switch consoles, but there is a
question of taste or style here: I prefer consistency of keyboard use
betweeen my Mac under Linux and the same Mac under MacOS. You seem to
prefer consistency with other Linux boxes with PC keyboards. As an
example, in Netscape, I like to be able to use Apple-x/c/v for
cut/copy/paste or Apple-q/w for quit/close, under both Linux and MacOS
(Mozilla adopted the Microsoft Ctrl-x/c/v/q/w, unfortunately). Likewise,
I like to have alt-shift-L for the pipe symbol on a French Mac keyboard
under both Linux and MacOS. This used to be the standard until very
recently. If this is no longer the default now, then I think I have the
right to apply some simple modifications to the keymaps in order to keep
my preferred behavior. And I think I have the right to explain to others
what I did.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
