Content-Type: text/plain;
  charset="us-ascii"
From: Trevor Woerner <ppc339@vtnet.ca>
Reply-To: ppc339@vtnet.ca
To: linuxppc-dev@lists.linuxppc.org
Subject: ide interrupts
Date: Fri, 23 May 2003 11:36:51 -0400
MIME-Version: 1.0
Message-Id: <200305231136.51119.ppc339@vtnet.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


There seems to be a lot of code in the IDE subsystem relating to
interrupts. Is there a way to set a device in polled (i.e.
non-interrupt) mode? Maybe some way to run the tasklet/bh periodically?

Does the IDE system want to monitor my ATA device's Ready_NotBusy
interrupt?

	Trevor

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
