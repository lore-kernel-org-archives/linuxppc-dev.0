Return-Path: <riesebie@lxtec.de>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net [83.223.95.98])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtpout.hostsharing.net",
	Issuer "Hostsharing eG Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 80BFFDDDD6
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 09:02:45 +1100 (EST)
Date: Tue, 13 Nov 2007 23:02:35 +0100
From: Elimar Riesebieter <riesebie@lxtec.de>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: 2.6.24-rc1 freezes on powerbook at first boot stage
Message-ID: <20071113220235.GB9008@frodo.home.lxtec.de>
References: <20071024120739.GA4897@aragorn.home.lxtec.de>
	<20071024124109.GA9442@frodo.home.lxtec.de>
	<20071104032006.GG9695@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20071104032006.GG9695@localdomain>
Cc: linuxppc-dev@ozlabs.org, linux-wireless@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 03 Nov 2007 the mental interface of
Nathan Lynch told:

[...]
> Does 2.6.23 (or any earlier kernel) work?
>=20

2.6.24-rc2 works so lala :)

Machine:

processor	: 0
cpu		: 7447A, altivec supported
clock		: 833.333000MHz
revision	: 0.2 (pvr 8003 0102)
bogomips	: 36.32
timebase	: 18432000
platform	: PowerMac
machine		: PowerBook5,6
motherboard	: PowerBook5,6 MacRISC3 Power Macintosh=20
detected as	: 287 (PowerBook G4 15")
pmac flags	: 0000001b
L2 cache	: 512K unified
pmac-generation	: NewWorld

b43 doesn't authenticate via wpa (bluetooth isn't loaded):
WEXT auth param 4 value 0x0 - ioctl[SIOCSIWAUTH]: Operation not supported
WEXT auth param 5 value 0x1 - Internet Systems Consortium DHCP Client V3.1.0

dmesg:
=2E.....
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
sysctl table check failed: /kernel .1 Writable sysctl directory
Call Trace:
[c1061e60] [c0008b28] show_stack+0x4c/0x1ac (unreliable)
[c1061ea0] [c0047354] set_fail+0x50/0x68
[c1061ec0] [c0047784] sysctl_check_table+0x418/0x714
[c1061f30] [c00335b8] register_sysctl_table+0x64/0xb4
[c1061f50] [c033fd5c] register_powersave_nap_sysctl+0x18/0x2c
[c1061f60] [c03391e4] kernel_init+0xc0/0x2a0
[c1061ff0] [c0011a58] kernel_thread+0x44/0x60
setup_kcore: restrict size=3D3fffffff
Registering PowerMac CPU frequency driver
=2E.....
ohci_hcd: Unknown symbol usb_hcd_pci_suspend
ohci_hcd: Unknown symbol usb_hcd_resume_root_hub
ohci_hcd: Unknown symbol usb_hcd_pci_probe
ohci_hcd: Unknown symbol usb_hcd_unlink_urb_from_ep
ohci_hcd: Unknown symbol usb_disabled
ohci_hcd: Unknown symbol usb_hcd_check_unlink_urb
ohci_hcd: Unknown symbol usb_calc_bus_time
ohci_hcd: Unknown symbol usb_hcd_pci_shutdown
ohci_hcd: Unknown symbol usb_hcd_link_urb_to_ep
ohci_hcd: Unknown symbol usb_hcd_pci_resume
ohci_hcd: Unknown symbol usb_put_hcd
ohci_hcd: Unknown symbol usb_hcd_giveback_urb
ohci_hcd: Unknown symbol usb_hcd_poll_rh_status
ohci_hcd: Unknown symbol usb_create_hcd
ohci_hcd: Unknown symbol usb_hcd_pci_remove
ohci_hcd: Unknown symbol usb_remove_hcd
ohci_hcd: Unknown symbol usb_add_hcd
ohci_hcd: Unknown symbol usb_root_hub_lost_power
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
=2E....

console-tools (kbd) doesn't work correct (No DPMS Blank on console)
(Using radeonfb) Boottime font isn't loaded on every vt.
=2E...

There is a lot to do, but it seems to be a big, big code change in
that version. This impressed me by looking at the git changes and
the size of patches. And the rc's don't seem to be frozend versions.
A lot of new code comes in....
Let me know whether a complete dmesg is needed.

Thanks
Elimar



--=20
  The path to source is always uphill!
                                -unknown-
