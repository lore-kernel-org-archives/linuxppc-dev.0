Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-ID: <20010227170238.55737.qmail@web11103.mail.yahoo.com>
Date: Tue, 27 Feb 2001 09:02:38 -0800 (PST)
From: gopi krishna <mgopik@yahoo.com>
Subject: Unable to read/write consistently to a device.
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi..

  We have custom board based on 860T running
linux2.2.14

  We have a device 0xf0040000.  This address has been
ioremapped.
(Hence directly using the physical address to access
the memory)

We tried to read the registers using:
  in_be32(addr)
  *address
  in_be32(volatile unsigned *addr)
but, none of them are giving any consistent results.

With BDM, we are able to get correct and consistent
results.

Can there be any cache/coherency/any other issues of
linux which we are overlooking?

thanx in advance
gopi


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
