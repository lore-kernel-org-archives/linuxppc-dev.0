Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <007001c2581e$af4a9900$370da8c0@aman>
From: "Aman" <aman@mistralsoftware.com>
To: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: NFS Mount
Date: Mon, 9 Sep 2002 22:03:52 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All
I have a basic question.
I have build a kernel image using the ppc linux source. Now I want to
download the image using NFS from the host. When I tried to boot the image I
am getting the following error.

VFS: Mounted root (nfs filesystem).
 Freeing unused kernel memory: 220k init
Warning: unable to open an initial console.
 Kernel panic: No init found.  Try passing init= option to kernel.
<0>Rebooting in 180 seconds..

My root path in the dhcpd.conf  is /hdb/mydir/mykernel , this where I have
un tar the linux kernel source for PPC.
In the exports file I have exported the path /hdb/mydir.

My doubt is , will there be a filesystem already in the linux source at the
location /hdb/mydir/mykernel or I have to create it. If I have create it,
how should I go about.

Please help me in solving this issue.

Thanking you in advance
Regards
Aman


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
