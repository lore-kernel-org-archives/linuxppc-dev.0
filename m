Date: Tue, 1 May 2001 17:39:01 -0700
From: John Cagle <jcagle@kernel.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405gp PCI?
Message-ID: <20010501173901.A14125@kernel.org>
References: <3AEE0E5C.955341B3@dominetsystems.com> <3AEE21DF.6C289B1C@mvista.com> <3AEF2381.755F7581@dominetsystems.com> <3AEF2AA5.5CB593C8@mvista.com> <3AEF3E8C.1EDEFA94@dominetsystems.com> <3AEF4A65.84AC7436@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3AEF4A65.84AC7436@mvista.com>; from frank_rowand@mvista.com on Tue, May 01, 2001 at 04:44:37PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 01, 2001 at 04:44:37PM -0700, Frank Rowand wrote:
>
> That's the problem....  That version of the OpenBios changed the PLB to
> PCI address mapping (the mapping is in the PMM0 registers).  The kernel
> expects PLB address 0x8000'0000 to map to PCI address 0x0000'0000, and the
> PMM registers should map PCI address 0x0000'0000 to PLB address 0x0000'0000.
> A near future kernel will fix up the PTM and PMM registers (on the Walnut
> only) to match what the kernel expects.
>

Until a newer kernel is released by Monta Vista, you can use setpci to
change the settings of the PCI bridge as follows:

  setpci -s 0:0.1 14.L=0x8

Regards,
John

------------------------------
John Cagle <jcagle@kernel.org>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
