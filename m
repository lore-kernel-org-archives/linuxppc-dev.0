Date: Sat, 31 Jan 2004 10:38:05 +0100
From: Giuliano Pochini <pochini@shiny.it>
To: LinuxPPC-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Problems with USB keyboard
Message-Id: <20040131103805.767fb149.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Linux Jay 2.6.2-rc1-ben1 #2 SMP Wed Jan 28 22:19:17 CET 2004 ppc unknown has
some problems initializing my USB keyboard (logitech internet navigator). I
have to detach/reattach it several times every boot to get a working
keyboard. The mouse is always recognized immediately. I never had problems
with 2.4.

>From dmesg, one of the failure messages:

hub 2-1:1.0: new USB device on port 1, assigned address 8
bus usb: add device 2-1.1
bound device '2-1.1' to driver 'usb'
bus usb: add device 2-1.1:1.0
hid: probe of 2-1.1:1.0 failed with error -5
bus usb: add device 2-1.1:1.1
hid: probe of 2-1.1:1.1 failed with error -5
usb 2-1.1: USB disconnect, address 8
bus usb: remove device 2-1.1:1.0
bus usb: remove device 2-1.1:1.1
bus usb: remove device 2-1.1

And finally...

hub 2-1:1.0: new USB device on port 1, assigned address 9
bus usb: add device 2-1.1
bound device '2-1.1' to driver 'usb'
bus usb: add device 2-1.1:1.0
input: USB HID v1.10 Keyboard [Logitech Logitech USB Keyboard] on usb-0001:01:1b.1-1.1
bound device '2-1.1:1.0' to driver 'hid'
bus usb: add device 2-1.1:1.1
input: USB HID v1.10 Mouse [Logitech Logitech USB Keyboard] on usb-0001:01:1b.1-1.1
bound device '2-1.1:1.1' to driver 'hid'


--
Giuliano.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
