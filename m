Message-ID: <3E70A2C3.8090305@tataelxsi.co.in>
Date: Thu, 13 Mar 2003 20:54:51 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: accessing immap_t * variable in mpc8260
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
We are writing existing drivers for mpc8260 FCC and writing new ones for
MCC. we are unable to small (may be foolish) problem of accessing immap
address registers.

In FCC code, eldk/ppc_82xx/usr/src/linux/arch/ppc/8260_io/fcc_enet.c,
immap_t * immap is simply typecasted to IMAP_ADDR, which is
((uint)0xf0000000).
Now, after assigning this physical address, fcc_enet code continues the
immap_t variable without doing any __va macro.

I am confused at this point, that how can kernel code access a physical
address as if it were virtual address ? how does the page frame -> page
conversion (and vice versa) happens on this front?

Thanks and regards,
Om.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
