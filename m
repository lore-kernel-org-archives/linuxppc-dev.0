Message-ID: <001101c2ee43$3831ea10$370da8c0@aman>
From: "Aman" <aman@mistralsoftware.com>
To: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: PPC kernel tree download error
Date: Wed, 19 Mar 2003 23:43:18 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All

This the first time , I am downloading the linuxppc_2_4_devel tree from the
following site using Bitkeeper for PPC IBM 440 image
http://penguinppc.org/dev/kernel.shtml. I used the following command to
download the linuxppc_2_4 tree

bk clone -d http://ppc.bkbits.net/linux_2_4_devel

After some time I get the following error
==========================================================================
Sfio has detected a name conflict between
"include/linux/netfilter_ipv4/SCCS/s.i
pt_dscp.h" and "include/linux/netfilter_ipv4/SCCS/s.ipt_DSCP.h";
This usually happens when you transfer file from a case-sensitive file
system (e.g. Unix) to a case insensitive file system (e.g FAT, NTFS)
Please rename one of the files and retry (see also "bk helptool mv")
Note: You must do the rename in the sending repository.
==========================================================================
write on fd gzip_in gunzip2fd: Broken pipe
ERROR: process 1064 is exiting and it has left the repository at
. write locked!!  This is the result of a process that has been
killed prematurely or is a bug.
socket2pipe: shutting down write socket

Administrator@WIN2KHOSTB ~
$ socket2pipe: reader error 2

Can anybody suggest , how  to overcome this error

Thanking you in advance

Regards
Aman


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
