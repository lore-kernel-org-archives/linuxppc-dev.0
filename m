Message-ID: <36C567ED.F1982DB5@iwate-u.ac.jp>
Date: Sat, 13 Feb 1999 21:54:21 +1000
From: Piotr Muszynski <u0295020@iwate-u.ac.jp>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
CC: Eric Guenterberg <mavpion@fire.csua.ucla.edu>,
        Paul Mackerras <paulus@cs.anu.edu.au>
Subject: Re: Linux 2.2.1 Kernel scsi troubles
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have the same problem (aborting MESH target) on my
7500/601/100MHz/64MB with 2 disks,  linuxppc r4:

binutils-2.9.1-19a
modutils-2.1.121-1
egcs-1.1-1b
egcs-c++-1.1-1b
egcs-as-gcc-1.1-1b
egcs-fixes-1-1
glibc-0.961212-1o
glibc-devel-0.961212-1o
glibc-static-0.961212-1o

/dev/sda -- MacOS,  with BootX/vmlinux    (Fireball) --> this one's
aborted
/dev/sdb -- half MacOS, half Linux        (IBM)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: QUANTUM  Model: FIREBALL1280S    Rev: 630G
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DCAS-32160       Rev: S65A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: SONY     Model: CD-ROM CDU-8005  Rev: 1.0j
  Type:   CD-ROM                           ANSI SCSI revision: 02

Is there anything I could help with?

BTW, vmlinux by Paul displayed only the welcome line.  2.2.1 boots
further (until failing on MESH) only after adding #ifdef __SMP__ /
#endif to arch/ppc/kernel/head.S (lines 1208/1212).

piotru


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
