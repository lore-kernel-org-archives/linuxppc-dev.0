To: linuxppc-embedded@lists.linuxppc.org
Subject: montavista gcc3.2.1 and USB hotplug  (405GP platform)
MIME-Version: 1.0
Message-ID: <OF5BBAD0EA.5A3EB257-ONC1256DB4.001F984E-C1256DB4.0020E13C@se.wavetek.com>
From: "Philippe Villet" <philippe.villet@acterna.com>
Date: Fri, 3 Oct 2003 07:45:42 +0200
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We were compiling Montavista 2.4.18 linuk kernel for our own platform
based on IBM405GP and a PIIX4 South Bridge.
Support for usbcore, usb-uhci and hid (keyboard an mouse support) is set
in the kernel and it works fine when we compile this kernel with
gcc 2.95. Now compiling exactely the same kernel tree with gcc 3.2.1; It
doesn't work any more;
Following messages are logged into the console when hot plugging a
keyboard :

root@172.16.27.217:~# hub.c: USB new device connect on bus1/1, assigned
device number 8
hub.c: USB hub found
hub.c: 3 ports detected
hub.c: USB new device connect on bus1/1/1, assigned device number 9
usb-uhci.c: uhci_submit_urb: pipesize for pipe 80000980 is zero
usb-uhci.c: uhci_submit_urb: pipesize for pipe 80000980 is zero
usb-uhci.c: uhci_submit_urb: pipesize for pipe 80000980 is zero
usb-uhci.c: uhci_submit_urb: pipesize for pipe 80000980 is zero
usb-uhci.c: uhci_submit_urb: pipesize for pipe 80000980 is zero
usb.c: unable to get device descriptor (error=-90)
hub.c: USB new device connect on bus1/1/1, assigned device number 10
usb-uhci.c: uhci_submit_urb: pipesize for pipe 80000a80 is zero
usb-uhci.c: uhci_submit_urb: pipesize for pipe 80000a80 is zero
usb-uhci.c: uhci_submit_urb: pipesize for pipe 80000a80 is zero
usb-uhci.c: uhci_submit_urb: pipesize for pipe 80000a80 is zero
usb-uhci.c: uhci_submit_urb: pipesize for pipe 80000a80 is zero
usb.c: unable to get device descriptor (error=-90)

If we plug the keyboard before booting the board, the keyboard works. In
both case the file system is the same.

Any suggestions
Thanks in advance.

Philippe.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
