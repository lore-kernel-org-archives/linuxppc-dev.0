Message-ID: <38D7B56B.3E351682@ncal.verio.com>
Date: Tue, 21 Mar 2000 09:46:19 -0800
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Powerbook 2000 (Pismo) status.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just a quick update on status for the PB2000,

The remaining media bay problems were fixed this weekend.

Ben Herrenschmidt fixed the color map problems on the mobility
chip for the aty128fb, and I debugged and tested them last night.
Once we verify a few fixes for offb, I think it will be time
to get a binary out for testing. Since Ben has mentioned
it on the user list, the sources are in his linux-pmac-benh source
tree at linuxcare.au if anyone with a compile platform wants
to try to involved in testing.

I have also been testing a version of the Rage Xpmac which
recognizes the Mobility chip courtesy of Kevin Hendricks.
No problems yet.

So far the networking is working well, I've seen transfers of
over 6MBs. If not connected at boot it detects an active line
being plugged in and initializes the PHY chip.

Remaining issues are inconveniences and several are shared with
the iBooks:

> Like the iBook there is no power management yet, the new
  PMU is undocumented and hasn't been reverse engineered. Ben's
  iBook has a dead hard disk which is holding up his efforts,
  though he seems to keep pretty busy on other projects...

> The LCD display is bright! There are no brightness or
  contrast controls yet, the question that needs to be
  researched is whether these are controlled by the PMU or
  the Rage Mobility's power management facilities.

> Sound??? Haven't tried, haven't even inquired as to the
  iBook's status.

> USB traps: some combinations of the keyboard and mouse I have
  will work on one boot and cause a trap on the next (I think
  the mouse, a Logitech 4-button scroller is causing the
  driver's confusion).

> PCMCIA/card slot: there is a new PCI bridge used that will
  need support.

> Support for the second framebuffer or mirroring the LCD
  framebuffer to the external monitor or video ports.

Henry

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
