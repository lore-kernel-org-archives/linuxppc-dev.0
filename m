Date: Fri, 6 Aug 2004 09:14:01 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Dan Malek <dan@embeddededge.com>
Cc: Ralph Siemsen <rsiemsen@rossvideo.com>,
	PPC_LINUX <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Init hangs
In-Reply-To: <884A8F94-E7A5-11D8-9B14-003065F9B7DC@embeddededge.com>
Message-ID: <Pine.LNX.4.60.0408060912370.7391@localhost.localdomain>
References: <20040806081151.B77FCC109F@atlas.denx.de> <411369F9.5060506@rossvideo.com>
 <884A8F94-E7A5-11D8-9B14-003065F9B7DC@embeddededge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 6 Aug 2004, Dan Malek wrote:

> On the MPC8xx, which does not have a floating point unit, there is
> still sufficient support in the kernel to trap and emulate FPU reset
> and context save/restore for this purpose.  You only need the
> CONFIG_MATH_EMULATION is you intend to really do floating point
> arithmetic.

thanks for that tidbit.  i've always wondered, for our 850DE, hmmm ...
math emulation or no math emulation?  i guess i can just make sure
it's turned off, and see if it ever causes a problem.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
