Message-ID: <20031031165821.17006.qmail@web41215.mail.yahoo.com>
Date: Fri, 31 Oct 2003 08:58:21 -0800 (PST)
From: Prakash Kanthi <pkanthi@yahoo.com>
Subject: Max RAM for Linux only 1GB?
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Folks,

I have over 1GB DIMM RAM on my board running PPC 405.
How can i ioremap that to my OS? As Linux virtual
space starts at 0xC0000000, we have only 1GB more for
all virtual space mappings.

Even if i move 0xC0000000 to 0x80000000, what will
happen to TLB settings? Any problem there to map 1GB
additional RAM?

Any idea as to how i can do this?

Thanks,
Prakash


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
