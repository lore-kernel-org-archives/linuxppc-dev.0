Message-ID: <3B947182.2D82706@india.infogain.com>
Date: Tue, 04 Sep 2001 11:45:30 +0530
From: ashish anand <ashisha@india.infogain.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Disabled UDMA feature?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,
I need to test UDMA feature implementation in my disks.
my disks are ATA standard one.

when i instruments the  ide driver's source code i find that my
disk is using PIO mode for data transfer.

On web for ATA standard disks it this is mentioned that
UDMA is now used by ATA disks also.
my disk also fall in those ATA standards.

hence ideally it should use but is there any specific reason
it is disabled?

this I asked if somebody already faced the similar situation
though i understand that i need to browse and further check in driver
code why UDMA feature is not being enabled...

Best Regards
Ashish,

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
