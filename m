Date: Wed, 26 Nov 2003 20:18:58 +0100
From: Peter Vandenabeele <peter.vandenabeele@mind.be>
To: linuxppc user <linuxppc@opqua.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: routing performance w/embedded linux on ppc?
Message-ID: <20031126201858.A7373@mind.be>
Reply-To: Peter Vandenabeele <peter.vandenabeele@mind.be>
References: <16694.138.89.83.168.1069733893.squirrel@www.opqua.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16694.138.89.83.168.1069733893.squirrel@www.opqua.com>; from linuxppc@opqua.com on Mon, Nov 24, 2003 at 11:18:13PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Nov 24, 2003 at 11:18:13PM -0500, linuxppc user wrote:
> I'm looking for some papers, pointers, or whatever regarding linux
> routing performance on midrange embedded ppc hardware, for example
> the moto8245 and ibm405GP (as used inside the Xilinx Virtex II Pro).

The core in the Virtex-II Pro is not a full 405GP but only a
PowerPC 405 core with MMU and caches in hard-core. When using soft-core
(IP) Ethernet implementations connected to the OPB bus (the slower
bus, compared to the PLB bus), the OPB bus bandwidth may be the
limiting factor.

Peter

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
