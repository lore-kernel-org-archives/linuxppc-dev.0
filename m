Message-ID: <39878794.641E19BB@routefree.com>
Date: Tue, 01 Aug 2000 19:29:40 -0700
From: "Nikhil G. Daddikar" <ngd@routefree.com>
MIME-Version: 1.0
To: LinuxPPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Matrox Framebuffer Driver
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am running linux on the IBM PPC 405GP walnut board and have a matrox
mystique PCI card. I would like to enable the framebuffer driver.
However, I get a  "matroxfb: cannot determine memory size" error on
bootup.

Here /proc/iomem
80000000-807fffff : Matrox Graphics, Inc. MGA 1064SG [Mystique]
80800000-80803fff : Matrox Graphics, Inc. MGA 1064SG [Mystique]
81000000-817fffff : Matrox Graphics, Inc. MGA 1064SG [Mystique]

Any help would be appreciated.

Thanks.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
