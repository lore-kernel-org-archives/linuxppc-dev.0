Message-ID: <01C0C905.51FB0A40@DESKTOP>
From: Paul W <paul_w@telocity.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: do_page_fault question
Date: Thu, 19 Apr 2001 19:16:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I brought up the 2.2.14 kernel (from Monta Vista) on an 860.
The only changes I made had to do with my board's uniqueness
in the serial and ethernet I/O. The kernel boots fine wit
an nfs root file system (one from Monta Vista) or an initrd
disk image. But once I get to init() I get swamped by messages
from do_page_fault() (here are the first 5):

address: 30025e30 nip:c000a7c8 code: 000048a6 data
address: 30025e30 nip:c000a7c8 code: 82000000 write I/O data
address: 10016fe8 nip:c000a7c8 code: 000048a6 data
address: 10016fe8 nip:c000a7c8 code: 82000000 write I/O data
address: 30010200 nip:30010200 code: 4000d032 604 tlb&htab miss instr

I took out the printk that's doing this and found that things
are working (shell comes up, I can enter commands and do things).
Any suggestions on how to fix this correctly would be appreciated.

Thanks,
Paul Westenkirchner


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
