From: Benjamin Herrenschmidt <bh40@calva.net>
To: Giuliano Pochini <pochini@shiny.it>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Lots of problems
Date: Fri, 3 Nov 2000 14:36:38 +0100
Message-Id: <19340928070822.11693@192.168.1.2>
In-Reply-To: <XFMail.001103111328.pochini@shiny.it>
References: <XFMail.001103111328.pochini@shiny.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Hi!
>This is a list of problems I have with official kernels and my G3 (350, SCSI)
>and a G4 (400, ide) of a friend:

Well, first, developement on PPC kernels is done on hq.fsmlabs.com
bitkeeper trees. Linus doesn't always have the latest fixes. We do send
patches quite regulary, but they are not always merged immediately by Linus.

Look at www.penguinppc.org for more infos about those trees.

Paul sent Linus a set of patches against test10 final, they have not been
merged by Linus yet.

>- 2.4.0t7: G3 and G4 OK. Resource collisions errors can be removed hacking
>pci.c.

>- 2.4.0t9, resource collisions: I can't boot my G3 because it doesn't see my
>SCSI controller. On the G4 it reports collisions even if there are no PCI
>cards.

PCI have been long fixed in the bitkeeper tree.

>- 2.4.0t9, USB: I tried HID, HIDBP, everything. No way to make USB working
>on the G4.

Works nicely with HID kbd on the bitkeeper tree.

>- 2.2.15p3, linuxppc2000: The G4 doesn't boot, lost interrupts.
>
>- 2.2.16+USB: The G4 doesn't boot, lost interrupts.
>
>- 2.2.16-something from YDL: G4, Works fine but a lots things are missing, I
>could not find the sources :(
>
>- 2.2.18p19: G3 crashes at boot, probably USB related (usb-HIDBP). G4 and
>usb-HID not tried yet (I'll do it this night).

For 2.2, I strongly suggest you use either the bitkeeper tree on
hq.fsmlabs.com, or Paul Mackerras rsync tree. I beleive Paul will send
updates to Alan soon, we have a huge diff against the official 2.2.x tree
for now.

>- all: G4 internal modem doesn't work. Suggestions ? I absolutely need it !!

That's something I've not checked. Paul fixed some internal modem issues
in macserial.c recently, I beleive those fixes are in the bk and rsync trees.

>- 2.4.0*: G4 ethernet goes at 100Mbps even if it's connected to a 10Mbps
>hub. Is
>there a way to force it to a lower speed ? Can the G3 eth go at 100MBps ?

You need the latest gmac driver which is, again, in the trees mentioned above.


Regards,
Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
