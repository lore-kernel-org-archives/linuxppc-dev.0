Date: Tue, 11 Apr 2000 20:35:17 +0200 (MET DST)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: what is wrong with kernel 2.3.x
In-Reply-To: <200004060459.XAA03920@lists.linuxppc.org>
Message-ID: <Pine.SOL.3.95.1000411201301.4181B-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 5 Apr 2000 18:22:05 -0400 (EDT), Scott Knight
<scott@re-104-1.read.indiana.edu> wrote:
>
> 	First off, right now Im using 2.3.51 but I saw the saem problems
> with 2.3.99-pre3 from the linuxcare rsync. ON the console when using the
> mouse to select stuff it inverts all the chareacteer sto weird thigns
> rather than hilighting them. Als with sound. on my 8500 for some reason
> the mixer for the microphone controls the rca input volume rather than the
> rca input volume controlling what it should. I havent been able to get the
> stable 2.2.x version from linuxcare to boot for some reason. All quite odd
> and agrravating. Im on a powerpc 8500 upgraded to g3/300 with 160MB memoy
> and 4MB vram with 2 2gig drives inside of it. Any and all insite would be
> greatly apprecaited.
>
Anything new on that topic? I'm seeing the same inverted characters on my
lombard under 2.3.99pre3, and pasting the stuff would only yield garbage.

I've also troubles with usb, but this might be largely because I'm not familiar
with the new designations. Do I need all of

CONFIG_USB_HID=y

CONFIG_INPUT_MOUSEDEV=y

for the mouse to work? I have compiled the first, and built the second as
module, I think, but any access to /dev/usbmouse (which is a link to
/dev/hid_something) gives an "unknown device" error.

A final woe: the kernel doesn't seem to know about the lower "Enter" key,
right of the spacebar, which is keycode 52 in 2.2.x. I used to define this as
right mousebutton, but in 2.3.99 it simply does nothing. showkey reports
a "button-press 0", but no button-release (sorry about the syntax, I hope
you know what I'm refering to). With the fn key pressed, it is properly
detected (keycode 72, iirc).
I've tried to find the keyboard definitions in the sources but couldn't
find anything I'd understand.

Any help is welcome, since the kernel seems to be very stable in general,
and dma is a _lot_ faster (at least for the CDROM) than in 2.2.15, but
with neither trackpad nor mouse working properly I find its use a bit
restricted ;^)

TIA,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
