Message-ID: <39D59806.9AE0F189@serialsystem.com.sg>
Date: Sat, 30 Sep 2000 14:36:38 +0700
From: Jari <jari.nguyen@smartstors.com>
Reply-To: jari.nguyen@smartstors.com
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Memory map?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

After booting kernel, I want to access the physical address in rom ,
for example:
my rom begins at 0xFE00 0000, and I want to read 1 byte at this address.

currently, the MMU has been turned on, the RAM begin at 0x0C00 0000,
and I don't know what the address of the ROM is.

what do I have to do?
is there anybody know how to take the address of the ROM?

Help me, pls.
Thank you,
Jari

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
