Cc: "'linuxppc-embedded@lists.linuxppc.org'"
    <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3958B37C.1F280F3F@lucent.com>
Date: Tue, 27 Jun 2000 09:00:28 -0500
From: Tom Roberts <tjroberts@lucent.com>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
Subject: Query: kernel version for MPC750/MPC7400
References: <7283DE19D141D111AD0E00A0C95B195502C5F5F2@mail2.aiinet.com> <3957DEFF.9064056E@netx4.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
> You shouldn't be using 2.2.15 with 8xx.  I am not going to discuss
> the history right now, but the only reliable verion of 2.2.xx Linux
> is the 2.2.13 version on the MontaVista Web site (www.mvista.com).

How about on an embedded MPC750 or MPC7400? Before joining this
list I discovered Kernel version 2.2.15 on Yellowdog and have been
using that. I have made a dozen or so small mods to the kernel to
get it to run on our boards, and have seen no problems, so far....
There are zillions of references to CONFIG_8xx throughout the source.

	These boards are essentially embedded supercomputers;
	the only devices they have are the drivers I wrote, which
	use memory buffers to/from the host PCI as a 'serial'
	console and a network interface.


Tom Roberts	tjroberts@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
