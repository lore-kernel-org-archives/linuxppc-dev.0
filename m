Date: Wed, 5 Mar 2003 10:10:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Dale Farnsworth <dale@farnsworth.org>,
	linuxppc-dev@lists.linuxppc.org, Troy Benjegerdes <hozer@hozed.org>
Subject: Re: Patch boot/common/relocate.S to start kernel at 0x000c
Message-ID: <20030305171020.GB19303@ip68-0-152-218.tc.ph.cox.net>
References: <15973.18737.651334.824024@argo.ozlabs.ibm.com> <20030305010318.6A4D3C6E0C@atlas.denx.de> <15973.24544.124365.553602@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15973.24544.124365.553602@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 05, 2003 at 01:24:32PM +1100, Paul Mackerras wrote:
> Wolfgang Denk writes:
>
> > BTW: _all_ this writing to kernel text is a Bad  Thing  (TM),  as  it
> > makes XIP (for example running from ROM) really difficult.
>
> Well, there is no reason why the secondary hold code shouldn't just
> reference an ordinary variable in the kernel data section.  It would
> take a couple more instructions, but that shouldn't be a problem.  The
> starting address for the secondary hold code needs to be well-known
> (at least to the prep boot wrapper) but the variable that it spins on
> doesn't.

Keep in mind that this issue has come up because there will be more
non-CONFIG_ALL_PPC SMP systems being supported.

Dale, how hard would it be to change the code you have (and the PReP
code as well which maybe we can get Troy to test :)) to do what Paul
suggested above and use an ordinary variable in the kernel data section?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
