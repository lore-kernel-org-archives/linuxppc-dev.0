Date: Mon, 23 Oct 2000 15:00:02 +0200
From: Olaf Hering <olh@suse.de>
To: Henning Löser <henning.loeser@physik.uni-marburg.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: gpm and XF401 (Re: ADB-Mouse)
Message-ID: <20001023150002.A3112@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
References: <200010210500.AAA23065@lists.linuxppc.org> <39F4351D.646B972F@physik.uni-marburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <39F4351D.646B972F@physik.uni-marburg.de>; from henning.loeser@physik.uni-marburg.de on Mon, Oct 23, 2000 at 02:55:00PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Oct 23, Henning Löser wrote:

> Hi,
> thanks I got my mouse working again ... well at least sort of, I do
> echo "1"  > /proc/sys/dev/mac_hid/keyboard_sends_linux_keycodes   and
> echo "1"  > /proc/sys/dev/mac_hid/mouse_button_emulation.
> Then the keyboard works with the .../i386/qwertz/de-latin-nodeadkeys.map.gz and even displays the 'Umlaute' in Emacs :-).
> The mouse moves now but the buttons only work sort of. If I mark something in the console to copy it, it scrambles the underlying text (intead of highlithing it) and only the scrambeled text gets copied. For example it makes "n~3" from "not" and ASCII
> code 'hex 02' from blanks ... Under X the mouse buttons behave funny aswell, instead of moving a window it looks as if it is resized, it's just that the part that is moved doesn't get drawn any more. If I do a xrefresh it turns out that the window was
> indeed moved ... This is propably a more X related problem, I have compiled the X401 from the sources with Ani Joshies xfree86 tree and Franz's xf4-kbdppc4.patch.
>
> Any sufggestions?

You mean you mark some text at console with gpm and all you get in the
selected area is garbage, even with a non psaux device?
I tried it here on a chrp machine and got the same effect, could be a
framebuffer bug. Anyone else with that problem?

I have XF4 here with kernel 2.4 and no problems at all (fbdev driver).



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
