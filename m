Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: phillip@lougher.demon.co.uk
To: linuxppc-embedded@lists.linuxppc.org
Subject: [FYI] Squashfs released (compressed fs for embedded systems)
Date: Wed, 30 Oct 2002 16:48:42 +0000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <E186w1K-0002n1-0U@anchor-post-39.mail.demon.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


First release of squashfs.

Squashfs is a highly compressed read-only filesystem for Linux (kernel 2.4.x). It uses zlib compression to compress both files, inodes and directories.  Inodes in the system are very small and all blocks are packed to minimise data overhead. Block sizes greater than 4K are supported up to a maximum of 32K.

Squashfs is intended for embedded systems, and for archival and general read-only filesystem use.

The filesystem was originally developed for an embedded PowerPC board (IBM Redwood variant), and so unusually for a Linux filesystem supports big-endian byte order (unlike Cramfs).  It however also supports other architectures, and has been tested on PowerPC, i586 and Sparc.

Squashfs is available from http://squashfs.sourceforge.net.

The patch file is currently against 2.4.19.  There is further info on the
filesystem design etc. in the README.

I'l be interested in getting any feedback...

Phillip Lougher


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
