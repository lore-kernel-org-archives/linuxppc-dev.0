Message-Id: <5.1.0.14.2.20010420115236.04112008@mail.lauterbach.com>
Date: Fri, 20 Apr 2001 12:12:52 +0200
To: Martin Costabel <costabel@wanadoo.fr>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: XF4, SysRq, VT, mouse buttons, Keymaps and all that
Cc: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3ADF3D42.483EF273@wanadoo.fr>
References: <20010419143631.8A7F72EFC2@apollo.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 21:32 19.04.2001, Martin Costabel wrote:
>Iain Sandoe wrote:
>[]
> > OK.  What's happened is that the VT combination has shifted from
> > <CMD>-<CNTL>-Fx to <ALT>-<CNTL>-Fx ... all OK now.  (the config was
> correct)
>[]
> > Additionally, like VT-switching, the modifier key appears to have
> changed to
> > <ALT> from <CMD>...
>[]
> > I guess that I must have missed a place to look for the changes that
> > occurred to the modifier keys etc.... perhaps Kaoru should add this
> > information to his ftp directory.  If people who monitor the -dev list
> don't
> > know, what chance have Users got ;-?
>
>The inversion of Alt and Cmd is actually mentioned in one if the
>LinuxPPC2000Q4 Readme files.
>And it is one of the first things I am always changing back in the
>keymaps. There is really no sane reason for it, and you *have* to undo
>it if you want a modifier key to get non-US characters on a US keyboard
>or an Apple-like keyboard layout on a non-US keyboard.

Please stop this keyboard layout bashing! I'm a getting bored by your wrong
patches on the lists. You can blame Apple for labeling the OPT key with
ALT, but that's it. Every linux doc talks about using ALT-CTRL-Fx for VT
switching and that's how it works now.

If you want to have it different, create a "XkbVariant SwitchOptCmd",
"XkbVariant Powerbook" etc. and _submit_ it to the XFree86 project.

If you are too lazy to fix it correctly, that's ok, but keep your hacks
private and stay off the lists with wrong patches (that will break on every
upgrade) that just confuse people.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
