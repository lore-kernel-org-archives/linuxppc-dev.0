Date: Thu, 19 Oct 2000 12:05:43 +0200 (MET DST)
From: Henning Loeser <Henning.Loeser@Physik.Uni-Marburg.DE>
To: linuxppc-dev@lists.linuxppc.org
Subject: ADB-Mouse
Message-ID: <Pine.OSF.4.02.10010190958400.3355-100000@ax1305.physik.uni-marburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
I just digged through the maillinglist but didn't come up with a solution,
so what did I miss ?
I compiled a linuxppc_2_3.snap from fmlabs from October 17th and it
compiled ok, booted, recognized my Acard AEC 6260M ide card, accepted my
l2cr setting and the voodoo3 card, booted from the ide-partition to
console login. The keyboard works ok (apple extended kb II) but the mouse
doesn't (ADB-mouse) /dev/adbmouse doesn't exist (claims gpm and X11).
dmesg reads the following:
Kernel command line: root=/dev/hda7 adb_buttons=111,55
video=tdfx:1024x768-8@60 l2cr=0xb9010000 video=ofonly
l2cr set to b9010000
[snip]
Macintosh CUDA driver v0.5 for Unified ADB.
[snip]
input0: Macintosh mouse button emulation
[snip]
adb devices: [2]: 2 5 [3]: 3 1
ADB keyboard at 2, handler set to 3
Detected ADB keyboard, type ISO, swapping keys.
input1: ADB HID on ID 2:2.05
ADB mouse at 3, handler set to 2
input2: ADB HID on ID 3:3.01
Macintosh non-volatile memory driver v1.0
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb.c: registered new driver hid
event0: Event device for input2
event1: Event device for input1
event2: Event device for input0
keybdev.c: Adding keyboard: input1
mouse0: PS/2 mouse device for input2
mouse1: PS/2 mouse device for input0
mice: PS/2 mouse device common for all mice

I do have /proc/device-tree/bandit/gc/via-cuda/adb/mouse/device_type
.../name and .../reg so I would think the mouse should be there, ...
shouldn't it?
Do I have to create a new /dev/adbmouse entry ? It works with 2.4.0-t2 ...

Henning

--------------------------------------------------------------------------
Henning Loeser					      Fachbereich Physik
email: henning.loeser@physik.uni-marburg.de	      AG Oberflaechen
						      Philipps-Uni Marburg


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
