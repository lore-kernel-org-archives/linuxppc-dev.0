Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F0545CA64@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Daniel Gonzalez'" <daniel.gonzalez@pandora.be>,
        Matthew Dharm
	 <mdharm-usb@one-eyed-alien.net>
Cc: Sheldon Easterbrook <sheldie@hotmail.com>, linuxppc-dev@lists.linuxppc.org,
        linux-usb@suse.com
Subject: RE: [linux-usb] Close to a solution. Please help !
Date: Mon, 24 Apr 2000 08:22:31 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Daniel,

Please send us your linux/.config file.


> Well. The sources I have are taken from linuxcare (I think that is Paul's
tree,
> isn't?). I am using the devel tree, since I heard that was performing
better for the
> USB subsystem.

and from kernel messages:

> Apr 24 13:58:26 dhcp-213-224-12-204 kernel: Linux version 2.3.99-pre6
(root@dhcp-213-224-12-204.kabel.pandora.be) (gcc version 2.95.2 19991024
(release)) #5 Mon Apr 24 13:25:37 EDT 2000

> Apr 24 13:51:11 dhcp-213-224-12-204 kernel: usb-ohci: Warning! Gobs of
> debugging output has been enabled.
> Apr 24 13:51:11 dhcp-213-224-12-204 kernel:           Check your
kern.debug
> logs for the bulk of it.
> Apr 24 13:51:11 dhcp-213-224-12-204 kernel: usbcore: Registered new driver
mouse
> Apr 24 13:51:11 dhcp-213-224-12-204 kernel: USB HID boot protocol mouse
> driver registered.
> Apr 24 13:51:11 dhcp-213-224-12-204 kernel: usbcore: Registered new driver
keyboard
> Apr 24 13:51:11 dhcp-213-224-12-204 kernel: usbcore: Registered new driver
hub
> Apr 24 13:51:11 dhcp-213-224-12-204 kernel: usbcore: Registered new driver
usb_scsi
> Apr 24 13:51:11 dhcp-213-224-12-204 kernel: USB SCSI support registered.


I'm still confused about what version of the kernel code this is.

The Linux boot message says 2.3.99-pre6, but the USB code is clearly
MUCH earlier than that.
Could you explain a little of how you came by this code?
I don't want the complete history, just enough to help us
understand what you are trying to use here.

Thanks,
Randy
___________________________________________________
|Randy Dunlap     Intel Corp., DAL    Sr. SW Engr.|
|randy.dunlap.at.intel.com            503-696-2055|
|NOTE:  Any views presented here are mine alone   |
|and may not represent the views of my employer.  |
|_________________________________________________|


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
