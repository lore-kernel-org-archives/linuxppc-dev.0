From: claude@convergence.de
Date: Tue, 2 May 2000 18:13:59 +0200
To: olh@suse.de
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Pismo boots then ?
Message-ID: <20000502181359.A1157@warez.convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I know that the linuxppc-dev-list is not intended for user support,
anyway, I hope that the point of my posting still won't have been
covered.

I finally get my pismo to boot linux using yaboot :

- created 4 partitions (mac hfs+,boot hfs,swap,linuxroot).
- made a copy of vmlinux kernel (from
  suseboot.hqx),yaboot,yaboot.conf,ramdisk.image.gz into the boot partition.
- edited the yaboot.conf as following
        timeout = 60
        default = install
        image = hd:10,vmlinux
        label = install
        initrd = hd:10,ramdisk.image.gz
        initrd-size = 8192

- as shown by the DriveSetup, my boot hfs partition had the number 9
- as shown with printenv in the OF, boot had the number 9
- finally, it has booted with number 10

-> typed "boot hd:10,yaboot" and then it booted

Finally, my kernel booted nice into the Suse install items, but I
haven't the suse CD (only the linuxppc1999 CD), and unfortunately I
wasn't able to continue my installation.

? Do I need absolutely one of the newest distribution CD (ppc2000 or
suseppc), or can I continue in an other way (using the linuxppc1999
distribution, or doing it via FTP, or even NFS).

Thanks for examining my request.

Bye.

---
claude

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
