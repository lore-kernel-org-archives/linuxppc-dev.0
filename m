From: Peter Bergner <bergner@brule.borg.umn.edu>
Date: Thu, 11 Oct 2001 08:11:23 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: SBS Palomar II/IV/V port
Message-ID: <20011011081123.B278838@brule.borg.umn.edu>
Reply-To: bergner@vnet.ibm.com
References: <0110092125.AA22665@ivan.Harhan.ORG> <20011010122415.A22918@boardwalk> <20011010180622.B11067@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011010180622.B11067@cpe-24-221-152-185.az.sprintbbd.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Oct 10, 2001 at 06:06:22PM -0700, Tom Rini wrote:
: > 1. The BI_INITRD boot record contains the start address and the size
: >    of the initrd.
: >
: > 2. The BI_INITRD boot record contains the entire initrd itself (as a
: >    really large boot record).
:
: I thought we had agreed on 1 (and nothing uses it yet anyhow).  Tho my
: memory could be hazy.

This was my understanding as well of the earlier conversations,
so this is what I used to implement zImage.initrd for ppc64.
Hopefully everyone remembers this not only affects the ppc32
kernel, but also affects the ppc64 kernel as well.

Peter

--
Peter Bergner
SLIC Optimizing Translator Development / Linux PPC64 Kernel Development
IBM Rochester, MN
bergner@vnet.ibm.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
