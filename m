Date: Wed, 30 Jun 2004 11:02:00 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: duplicate menu entry in 2.5 source tree?
Message-ID: <Pine.LNX.4.60.0406301057540.18007@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   does anyone else see a duplicate menu entry in the current 2.5 bk
pull, under Serial drivers (selecting RPXLite for me):

< > 8250/16550 and compatible serial support
--- Non-8250 serial port support
< > CPM2 SCC/SMC serial port support
< > CPM2 SCC/SMC serial port support    ????

   if you select either one, then both submenus pop up.  the Kconfig
file (drivers/serial/Kconfig) has the menu definition:

config SERIAL_CPM
         tristate "CPM2 SCC/SMC serial port support"
         depends on CPM2 || 8xx
         select SERIAL_CORE
         help
           This driver supports the SCC and SMC serial ports on Motorola
           embedded PowerPC that contain a CPM2 (8xxx) or a CPM1 (8xx)

i haven't looked more closely than that, just thought i'd mention it.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
