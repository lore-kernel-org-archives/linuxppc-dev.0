Message-ID: <3999AC2A.1057C171@denise.shiny.it>
Date: Tue, 15 Aug 2000 16:46:34 -0400
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.4 ... works
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I compiled 2.4 for the first time.

At boot it complains: "PCI device 01:02.0 non available
because of resource collisions" and again for 01:03.0.
They are my 2 SCSI controllers... and it doesn't boot.
I patches pci.c to ignore the error and now it seems to
work fine, but I don't like that hack.
PPP doesn't work. Do I need a more recent pppd ?


Bye.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
