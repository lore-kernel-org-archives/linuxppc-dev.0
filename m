To: linuxppc-dev@lists.linuxppc.org
Subject: Firewire/SBP-2 working
From: Daniel Berlin <dberlin@redhat.com>
Date: 08 Mar 2001 13:10:53 -0500
Message-ID: <m2hf14t9le.fsf@dynamic-addr-83-177.resnet.rochester.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


scsi_info /dev/sda

SCSI_ID="0,0,0"
MODEL="WDIGTL WDxxxA001RTL"
FW_REV="52.1"

df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hda12             4810912   3627940   1036308  78% /
/dev/hda10               10235       333      9902   3% /mac/boot
/dev/build_space2/lvol1
                      43953472    450760  43502712   1% /buildspace2

(For those who can't tell, /dev/sda==/dev/build_space2/lvol1 is a 45 gig firewire drive
attached to my powerbook pismo).


Due to various stupidity (some of the firewire drive bridges,
including this one, have a 128k max transfer size limitation, and do
the wrong thing when presented with larger transfers), i'm only
getting 7 meg a second on the drive right now.
It'll improve.


But, look at the linux1394-devel list for all of my patches to
ohci1394, and the SBP-2 patches you'll need.

--Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
