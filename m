Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: greggiraud@netcourrier.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: using bdi2000
Date: Mon, 21 Apr 2003 12:22:53 CEST
Mime-Version: 1.0
Message-Id: <mnet1.1050920573.22642.greggiraud@netcourrier.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I am trying to debug my linux with a bdi2000.
I succeed in loading ppcboot into flash. But I can't debug!

pc_82xx-gdb
target remote 192.168.15.3:2001

And then how to say the debugger to break at a specific line in a specific file like l 23 in uart.c?

thanks for helping
grego
greggiraud@netcourrier.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
