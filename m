Date: Mon, 14 Jul 2003 08:07:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: maurie <maurie@risc.sps.mot.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linuxppc 8245 lost interrupt
Message-ID: <20030714150739.GA2840@ip68-0-152-218.tc.ph.cox.net>
References: <000101c346ee$46545ac0$9b7c520a@sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000101c346ee$46545ac0$9b7c520a@sps.mot.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jul 10, 2003 at 09:19:28AM -0500, maurie wrote:
>
> 	I am building linux for the Sandpoint X3 with the Unity (MPC8245
> V1.1).  I have attempted this boot with all available speeds and bus speeds
> with the same result.
> 	I have used the same linux kernel with this Sandpoint X3 and a VAlis
> (MPC7457) and it reads the harddrive and boots correctly.
> 	I am using kernel 2.4.21-rc1.
> 	I have the sandpoint switches set for default.  I have the PMC
> switches set for default, except that I have PROGMODE set to Swap local
> flash to program and M66EN set to 33 MHz PCI only.
> 	My problem is that on the 8245, linux will recognize the harddrive,
> but then it gets "lost interrupt" while attempting to read the partition
> table and later when trying to boot from this hard drive.

Do you have other Sandpoint X3 chasis around?  At one point I managed to
convince myself that I had a chasis with busted IDE support by taking
the same PMC card, same binary kernel and two X3 chasis.  Same harddrive
would work on one, not the other.  This, along with trying a more recent
kernel might be a good idea.  Also, I see you modified the kernel to use
all 128mb of memory.  Try going back to the hard-coded 32mb of memory.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
