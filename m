Subject: 405GP TLBHI "E" field
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 21 May 2002 10:04:21 -0400
Message-ID: <3D296C067098F149B11A8F4FC37C054606F4E8@EXVS1.ops.infiniswitch.com>
From: "Curry, Diane" <dcurry@infiniswitch.com>
To: "Linuxppc Newsgroup (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
  I'm running 2.4.14pre3 on a custom ppc405GP board that has a little-endian device
on the peripheral bus.  I've modified the finish_tlb_load code path to recognize the
physical address of the device and set the "E" bit in the tlb entry for the page.
The driver and device work fine using this feature, but what I did in finish_tlb_load
is not a reasonable solution.  Is there a kernel interface callable from a driver
that can be used to specify the endianness of a memory range, and set the "E"
bit appropriately?  If not, are there any plans to implement this capability?

Thanks, in advance.

Diane Curry


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
