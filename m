From: "Bob White" <bwhite@perigee.com>
To: linuxppc-embedded@lists.linuxppc.org
Date: Thu, 06 May 2004 11:35:31 -0400
MIME-Version: 1.0
Subject: DPRAM driver on 440gp
Message-ID: <409A2303.2640.2967B3DD@localhost>
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've got a basic read/write driver working (thanks to O'reilly ldd2) on
the dpram on the peripheral bus.

I remap the physical addresses using "io_base = ioremap64(...)" in the
driver open call and then the user read and write functions can access
the dpram just fine.

I'd like the user to be able to access the dpram using a pointer, but I
am having trouble figuring out the mmap examples.

Given that the physical address has already been mapped, via
ioremap64(), do I need remap_page_range()?  Does anyone have any ideas
on what the mmap file_op for this driver would look like?  Do I even
need mmap() or should I just use an ioctl to return the pointer I've
already got to the user?

Bob
--
Robert B. White        Perigee, A Division of Sensis Corp
Software Design Engr   316 Commerce Blvd.
TEL: 315.453.7842x29   Liverpool, NY  13088
FAX: 315.453.7917      www.Perigee.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
