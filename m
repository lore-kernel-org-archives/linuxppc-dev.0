Message-ID: <3ADF63A5.C4FC9969@ncal.verio.com>
Date: Thu, 19 Apr 2001 15:16:05 -0700
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Darwin AGPGART?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Looks like the uniNorth AGP GART finally made it into the Darwin
CVS (xnu-4-2/iokit/Drivers/pci/drvApplePCI/AppleMacRiscPCI.[ch]
and generic i/f defs in xnu-4-2/iokit/IOKit/pci/IOAGPDevice.h).
Before I dig too deeply into this, has anyone looked into it
yet?

Henry

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
