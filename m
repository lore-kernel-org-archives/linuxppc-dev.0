Message-ID: <39C3F4DA.2363A35E@mvista.com>
Date: Sat, 16 Sep 2000 18:31:54 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: BK 2.4-test8 PCI/USB/G4
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


For those of you using the latest 2.4 BitKeeper tree on a G4, I have
a partial solution to making USB work again.  After pulling updates,
simply 'bk get -r1.18 arch/ppc/kernel/pci.c', which will get the
previous version of this file.  Build the kernel and at least you get
the mouse/keyboard, X, and stuff like that again.  At least you can
make progress on other tasks while we sort this out.

Have fun!


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
