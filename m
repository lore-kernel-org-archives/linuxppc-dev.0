Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <01C15BA3.FEB5AAC0.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>,
	"Redhat-devel-list (E-mail)" <redhat-devel-list@redhat.com>
Subject: Local RAM Disk w/mpc8xx-2.2.13
Date: Tue, 23 Oct 2001 09:20:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has anyone ever successfully used Redhat's EDK mpc8xx-2.2.13,
not using NFS for initial RAM Disk access, but using a local initial
RAM Disk (zipped or unzipped) downloaded with the zImage?

I have, in the past, successfully used NFS on the MBX dev bd, and
ran my apps with no problems.  Now, on a new custom bd, I am
downloading the init RAM Disk with the zImage, and sometimes it
works and sometimes not. This depends on whether I add or
subtract printk()'s to the kernel code. Modifying the initrd code has
no effect.  If I make the RAM Disk zipped or unzipped and make sure
it is copied to a Page-aligned section of RAM, it still exhibits
this same problem.   I initially thought the problem was in the gunzipping
of the initrd, but even downloading an unzipped initrd doesn't help.

Help!


Steven
Valcom, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
