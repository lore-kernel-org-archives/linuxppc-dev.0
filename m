Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3D76870E.5244CED5@seranoa.com>
Date: Wed, 04 Sep 2002 18:19:58 -0400
From: Tom Stefanski <tom.stefanski@seranoa.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Can't disassemble my device driver
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have a adatron bdi 2000 connected to my target board and have
successfully load the linux kernel and set breakpoint in schedule
However when I load my device driver, it's text section is a 0xD11D6060
and the kernel is a 0xC00xxxxx. When is disassemble any routine in my
driver, I get all zeros.

 I have MMU xlate set in the config file and I program the mmu correctly
since I can break a schedule. Any help would be apprecciated


 Tom


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
