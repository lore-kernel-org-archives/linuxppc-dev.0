Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 521B42BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Oct 2004 08:19:03 +1000 (EST)
Date: Fri, 22 Oct 2004 15:19:00 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "Smith, Gene" <gene.smith@siemens.com>
Message-ID: <20041022151900.E28106@home.com>
References: <4179628F.1020703@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4179628F.1020703@siemens.com>;
	from gene.smith@siemens.com on Fri, Oct 22, 2004 at 03:42:07PM
	-0400
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Basic 405gp question
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Oct 22, 2004 at 03:42:07PM -0400, Smith, Gene wrote:
> I have a custom 405GPr board containing 64M ram and 4M flash with no PCI 
> connector, just ethernet and ttyS0/1 to outside world. I am able to load 
> and run simple ppc code to ram using a Macraigor JTAG debugger via 
> insight/gdb using gnu tools provided by them.
> 
> What would it take to get linux running on this board? Any pointers or 
> suggestions would be appreciated.

Port u-boot using walnut code as an example.

Copy the Linux walnut code to foo_board.[c|h]. Remove what you don't need
from the files. Modify other things accordingly. Update the
Kconfigs/Makefiles.

Unless the hardware is buggy, it should be very straightforward. You
can even proof of concept things by loading vmlinux from your JTAG
debugger and setting r3-r7 appropriately...skipping the firmware stage.

-Matt
