Message-ID: <XFMail.001103111328.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
Date: Fri, 03 Nov 2000 11:13:28 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: linuxppc-dev@lists.linuxppc.org
Subject: Lots of problems
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!
This is a list of problems I have with official kernels and my G3 (350, SCSI)
and a G4 (400, ide) of a friend:


- 2.4.0t7: G3 and G4 OK. Resource collisions errors can be removed hacking
pci.c.

- 2.4.0t9, resource collisions: I can't boot my G3 because it doesn't see my
SCSI controller. On the G4 it reports collisions even if there are no PCI
cards.

- 2.4.0t9, USB: I tried HID, HIDBP, everything. No way to make USB working
on the G4.

- 2.2.15p3, linuxppc2000: The G4 doesn't boot, lost interrupts.

- 2.2.16+USB: The G4 doesn't boot, lost interrupts.

- 2.2.16-something from YDL: G4, Works fine but a lots things are missing, I
could not find the sources :(

- 2.2.18p19: G3 crashes at boot, probably USB related (usb-HIDBP). G4 and
usb-HID not tried yet (I'll do it this night).

- all: G4 internal modem doesn't work. Suggestions ? I absolutely need it !!

- 2.4.0*: G4 ethernet goes at 100Mbps even if it's connected to a 10Mbps hub. Is
there a way to force it to a lower speed ? Can the G3 eth go at 100MBps ?

How/where can I get the latest ppc patches ?

Bye.
    Giuliano Pochini ->)|(<- Shiny Corporation {AS6665} ->)|(<-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
