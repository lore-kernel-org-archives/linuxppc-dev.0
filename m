Message-ID: <39F4351D.646B972F@physik.uni-marburg.de>
Date: Mon, 23 Oct 2000 14:55:00 +0200
From: Henning Lvser <henning.loeser@physik.uni-marburg.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org, Olaf Hering <olh@suse.de>
Subject: gpm and XF401 (Re: ADB-Mouse)
References: <200010210500.AAA23065@lists.linuxppc.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
thanks I got my mouse working again ... well at least sort of, I do
echo "1"  > /proc/sys/dev/mac_hid/keyboard_sends_linux_keycodes   and
echo "1"  > /proc/sys/dev/mac_hid/mouse_button_emulation.
Then the keyboard works with the .../i386/qwertz/de-latin-nodeadkeys.map.gz and even displays the 'Umlaute' in Emacs :-).
The mouse moves now but the buttons only work sort of. If I mark something in the console to copy it, it scrambles the underlying text (intead of highlithing it) and only the scrambeled text gets copied. For example it makes "n~3" from "not" and ASCII
code 'hex 02' from blanks ... Under X the mouse buttons behave funny aswell, instead of moving a window it looks as if it is resized, it's just that the part that is moved doesn't get drawn any more. If I do a xrefresh it turns out that the window was
indeed moved ... This is propably a more X related problem, I have compiled the X401 from the sources with Ani Joshies xfree86 tree and Franz's xf4-kbdppc4.patch.

Any sufggestions?

Henning

> Date: Fri, 20 Oct 2000 12:18:26 +0200
> From: Olaf Hering <olh@suse.de>
> Subject: Re: ADB-Mouse
>
> On Fri, Oct 20, Topi Kanerva wrote:
>
> > guys, how exactly do you make it to work?
>
> Put that in boot.local:
>
> echo "1"  > /proc/sys/dev/mac_hid/mouse_button_emulation
> echo "87" > /proc/sys/dev/mac_hid/mouse_button3_keycode # F11
> echo "88" > /proc/sys/dev/mac_hid/mouse_button2_keycode # F12
>
> Gruss Olaf

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
