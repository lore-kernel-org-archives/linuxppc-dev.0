Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910809241451x7492d2a9s56b4cb4ee0fe0244@mail.gmail.com>
Date: Wed, 24 Sep 2008 17:51:04 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: USB support on mpc5200 broken
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

USB is not working my hardware, so I booted my Efika and it's not
working there either.  This is with linus' current git.

Can anyone verify this? Or know what happened to USB?
USB is loading but it is not finding anything plugged in.
lsusb doesn't show anything.

Last time I noticed it was working was about ten days ago. I don't use
it everyday.

usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
ASoC version 0.31
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
NET: Registered protocol family 1
audit: initializing netlink socket (disabled)
type=2000 audit(1222292382.243:1): initialized
msgmni has been set to 247 for ipc namespace c0316b94
io scheduler noop registered
io scheduler deadline registered (default)
Macintosh non-volatile memory driver v1.1
Serial: MPC52xx PSC UART driver
f0002000.serial: ttyPSC0 at MMIO 0xf0002000 (irq = 129) is a MPC52xx PSC
brd: module loaded
loop: module loaded
mpc52xx MII bus: probed
net eth0: Using PHY at MDIO address 16
Driver 'sd' needs updating - please use bus_type methods
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
i2c /dev entries driver
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.16.
tas5504_driver_init
mpc52xx_i2s_driver_init
digispeaker_driver_init
ALSA device list:
  No soundcards found.
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
net eth0: attached phy 16 to driver Generic PHY
Sending DHCP requests .<6>PHY: f0003000:10 - Link is Up - 100/Full
., OK
IP-Config: Got DHCP answer from 192.168.1.1, my address is 192.168.1.109
IP-Config: Complete:
     device=eth0, addr=192.168.1.109, mask=255.255.255.0, gw=192.168.1.1,
     host=192.168.1.109, domain=, nis-domain=(none),
     bootserver=192.168.1.1, rootserver=192.168.1.4, rootpath=
Looking up port of RPC 100003/3 on 192.168.1.4
Looking up port of RPC 100005/3 on 192.168.1.4



-- 
Jon Smirl
jonsmirl@gmail.com
