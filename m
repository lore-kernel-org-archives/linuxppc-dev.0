Message-ID: <40B8EECF.7050503@246tNt.com>
Date: Sat, 29 May 2004 22:13:03 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Making a "paged" sram aread appear as linear.
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Hi,

Let's say I have a device on the SRAM bus that an internal RAM of
8Mbyte. It's connected to the MCU on it's SRAM bus. But on the SRAM
bus, It only has two window of 64k. One is all the control registers
and the other can be mapped to any 64k segment of the device internal RAM.

Now, I'd like that a user space process can mmap / open / read / write
this aread as if it was linear. So what I thinked of was to allocate a
contiguous area of 8Mb, then only really map the current active 64k
area and then set a "handler" to catch access to the others area so it
can set the active page. The problem is that I have no idea if that's
possible, or how to do it.

Any advice, pointers ?


Sylvain Munaut


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
