To: linuxppc-dev@lists.linuxppc.org
Subject: Trouble compiling kernel for G5.
From: Stefan Berndtsson <stefan@nocrew.org>
Date: Fri, 09 Jan 2004 18:24:14 +0100
Message-ID: <874qv5c9xd.fsf@hades.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


When trying to compile the latest rsynced kernel (checked today, 2004-01-09)
from source.mvista.com::linuxppc-2.5-benh (2.6.1-rc1-ben1) for my G5, I
run into the following message with SATA:

  CC      drivers/scsi/sata_svw.o
drivers/scsi/sata_svw.c:236: error: request for member `bios_param' in something not a structure or union
drivers/scsi/sata_svw.c:236: error: initializer element is not constant
drivers/scsi/sata_svw.c:236: error: (near initialization for `k2_sata_sht.proc_info')
drivers/scsi/sata_svw.c: In function `k2_sata_init_one':
drivers/scsi/sata_svw.c:369: warning: label `err_out_unmap' defined but not used
make[2]: *** [drivers/scsi/sata_svw.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

My .config can be found at http://stefan.nocrew.org/config-g5.txt

GCC version is 3.3.3, currently running kernel 2.6.0-test10.

Anything else needed from me?

/Stefan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
