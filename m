From: ppclinux@sundmangroup.com
Message-ID: <36550.81.227.175.114.1081274911.squirrel@webmail.unisite.se>
Date: Tue, 6 Apr 2004 20:08:31 +0200 (CEST)
Subject: Segmentation fault
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
We have a Motorola-PPC8270 based inhouse blade which runs Uboot-1.0.2 and
Mvista 3.1 Linux.

We have succeeded in downloading the kernel by means of Uboots TFTP,
uncompress, start and NFS mount a rootfile system including Busybox.

However, when typing e.g. command "ls" we get a segmentation fault but
other commands like "cd" or "help" works fine. Could this be a incorrect
memory mapping problem? It seems that the Linux Kernel wants to fork a
process when doing e.g. "ls" and in that sequence fails and gets a
segmentation fault.

Happy for any guidance,

Cheers // Matias

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
