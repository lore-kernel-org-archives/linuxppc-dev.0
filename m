Message-ID: <3FC6817D.7090403@jonmasters.org>
Date: Thu, 27 Nov 2003 22:58:05 +0000
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Jon Masters <jonathan@jonmasters.org>
Cc: Peter Vandenabeele <peter.vandenabeele@mind.be>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Fwd: ppc4xx Ports]
References: <3FB416F9.7080303@jonmasters.org> <20031114002023.GA9509@gate.ebshome.net> <3FB423AB.80805@jonmasters.org> <20031114004805.GA9585@gate.ebshome.net> <20031126165238.O7373@mind.be> <3FC68039.4080206@jonmasters.org>
In-Reply-To: <3FC68039.4080206@jonmasters.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Jon Masters wrote:

| I think I mentioned before that I already fixed that for the port I am
| working on by incrementing next TLB entry by 2 if on Virtex II Pro.
| Actually if you check a post I made to comp.arch.fpga over the summer...
| I call it CONFIG_BROKEN_XILINX_TLB or something like that (other ports
| are now starting to fix that too) - several other errata too.

I also force TLB pinning on my port and modify where the kernel TLB
entries go while also forcing in a pinning for serial early on.

Montavista or someone added a patch to do that anyway now but remember I
am using stock kernels and none of the Montavista trees :-).

Cheers,

Jon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
