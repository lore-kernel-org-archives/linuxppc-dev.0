Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3EDB8199.8090805@imc-berlin.de>
Date: Mon, 02 Jun 2003 18:55:53 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: jffs2 partition on a TQM860L???
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I want to use JFFS2 as root fs on a TQM860L with 8MB flash.
This flash is seperated into two flash banks each 4MB.

(How) can I define one big jffs2 partition (in
./drivers/mtd/maps/tqm8xxl.c) that contains sectors from both flash banks?

Thanks a million,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
