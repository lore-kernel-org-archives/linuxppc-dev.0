Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C7654F8.3010801@capflow.com>
Date: Fri, 22 Feb 2002 15:26:00 +0100
From: Laurent Pinchart <laurent.pinchart@capflow.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Embedded MPC860T & flash memory
Content-Type: text/plain; charset=us-ascii; format=flowed
Reply-To: laurent.pinchart@capflow.com
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody,

I'm developping a custom MPC860T board, and need 16MB of flash memory.

As I need to be able to write to the memory using the MTD layer, I was
wondering if it would be better to use 2 16-bit wide chips in
interleaved mode on a 32-bit bus (connecting them in parallel to the
bus, one of them storing D[0:15] and the other one D[16:31]), or to use
them in non-interleaved mode (non-overlapping address ranges) on a
16-bit bus. It seems that the Linux MTD layer can support both
configurations, but I don't have a deep knowledge of that code, and thus
would appreciate any advice.

I'll probably use AMD devices.

Thanks in advance for your help.

Laurent Pinchart


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
