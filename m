Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20040120011332.12136.qmail@web11601.mail.yahoo.com>
Date: Mon, 19 Jan 2004 17:13:32 -0800 (PST)
From: Shamile Khan <shamile@yahoo.com>
Subject: 8-bit mtd flash support
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,

I am faced with a situation where my processor is connected
to 1 NOR flash chip in 8-bit mode. Now the consequence of
this is that I cannot excute code directly from flash. I am
not concerned about the performance penalties at this point
as I believe in the next rev of our board this problem
should be fixed in hardware.(i.e. 32 bit access to flash).
I was wondering if
a) Its a valid concept to have a Linux mtd flash filesystem
where the flash chip only allows 8-bit access
b) anyone else has been in this situation and
c) if there are mtd drivers available for 8-bit access to a
flash chip.

Regards,
Shamile


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
