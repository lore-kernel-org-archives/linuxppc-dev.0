Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <40EA6996.1010402@imc-berlin.de>
Date: Tue, 06 Jul 2004 10:57:58 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: ATAG for MAC address???
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

could we introduce an ATAG_MAC or ATAG_ETH_MAC so we can pass the MAC
address for the ethernet controller from the boot loader to the linux kernel
using the ATAG mechanism?

I don't want to pass "MAC=..." as a commandline though.

Thanks!

--
Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
