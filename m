Message-Id: <200104162121.XAA01103@piglet.grunz.lu>
Date: Mon, 16 Apr 2001 23:21:50 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: TiBook trackpad in benh's kernel?
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Anyone else seen this? I can't get the trackpad on my TiBook working
with benh's latest tres (rsync'ed a few days ago).

I tried adding a few printk's, but there seem to never be any data
coming from the trackpad. ALso, the 'trackpad' tool claims there is no
trackpad.

Ideas? I do think it is detected on bootup:

adb devices: [2]: 2 c4 [3]: 3 1 [7]: 7 1f
ADB keyboard at 2, handler 1
Detected ADB keyboard, type ISO, swapping keys.
event1: Event device for input1
keybdev.c: Adding keyboard: input1
input1: ADB HID on ID 2:2.c4
event2: Event device for input2
input2: ADB HID on ID 7:7.1f
ADB mouse at 3, handler set to 4 (trackpad)
event3: Event device for input3
mouse1: PS/2 mouse device for input3
input3: ADB HID on ID 3:3.01
adb: finished probe task...

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
