Date: Fri, 26 Oct 2001 16:06:44 -0700
From: Jeffery von Ronne <jronne@ics.uci.edu>
To: linux-usb-devel@lists.sourceforge.net,
	linuxppc-dev@lists.linuxppc.org
Subject: NEC 1525M usb hub dying after extended inactivity
Message-ID: <20011026160644.E28470@reepicheep.ics.uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have a NEC LCD1525M monitor, which comes with a 4 port USB hub to
which my keyboard and mouse are attached.  It works fine unless I leave
it overnight; at which point the machine no longer responds to the
mouse and keyboard.  Unplugging and replugging the keyboard has no
effect, but unplugging and replugging in the cable between the system
and the hub makes everything work again.  Does anybody have any idea
what could be causing this?  I'm guessing the hub is going into some
kind of power saving mode because of inactivity.

The relevant lines from /proc/bus/usb (at least if I'm parsing it correctly):
T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 22 Spd=12  MxCh= 4
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0409 ProdID=55ab Rev= 2.00
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms

The machine is a 450MHz G4 macintosh, running Yellow Dog Linux 2.0.
It is currently using Linux 2.4.13-pre3 derived kernel rsync'ed
Tuesday morning from rsync.penguinppc.org::linux-2.4-benh.

Thanks.

P.S. The /proc/bus/usb/devices output for the motherboard USB port is:
T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=132/900 us (15%), #Int=  4, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB OHCI Root Hub
S:  SerialNumber=f202b000
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

--
Jeffery von Ronne <jronne@ics.uci.edu>
Graduate Student
Information and Computer Science
University of California, Irvine


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
