Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: greggiraud@netcourrier.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: ppcboot 8260 LXT971A
Date: Mon, 30 Jun 2003 10:12:10 CEST
Mime-Version: 1.0
Message-Id: <mnet1.1056960730.12133.greggiraud@netcourrier.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I installed a ppcboot and a linux 2.4 on a MPC8260ADS card.

Now, I am working on a custom card such as an MPC8260ADS card. The difference between those two cards is the ethernet: my custom card has two ethernet port, and uses two LXT971A.

So, I compile a ppcboot for 8260ads. PPCBOOT can't download a kernel with tftp. Is someone has a source code to support the LXT971?

I compile a new kernel, which support LXT971A. PPCBOOT can run it from memory. But the kernel doesn't have network.

please can someone help me?

grego
greggiraud@netcourrier.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
