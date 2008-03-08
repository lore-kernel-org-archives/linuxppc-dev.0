Return-Path: <dgibson@ozlabs.org>
Date: Sat, 8 Mar 2008 11:37:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Add local bus device nodes to MPC837xMDS device trees.
Message-ID: <20080308003742.GA1009@localhost.localdomain>
References: <1204800155-11613-1-git-send-email-leoli@freescale.com>
	<20080307002730.GB24142@localhost.localdomain>
	<A984ECC2-9094-4045-B49E-95D924E6AAD2@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A984ECC2-9094-4045-B49E-95D924E6AAD2@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 07, 2008 at 08:35:39AM -0600, Kumar Gala wrote:
> On Mar 6, 2008, at 6:27 PM, David Gibson wrote:
[snip]
> > I've seen several variants for board control devices (cpld, bcsr,
> > fpga, etc.) I suggest we standardise on "board-control"
> 
> I don't see any reason for this.  If I have a cpld or fpga why not  
> just call it that.  I don't see what calling it 'board-control' gets  
> us.  There may be non-board control functionality in an fpga than what  
> do we call it?

Exactly!  The device tree is supposed to describe the hardware from a
functional perspective, so the fact that something is implemented in
an fpga or cpld is irrelevant, what matters is what's inside the fpga.

If an fpga was used to implement an ethernet MAC, we'd call if
"ethernet", if something else, something else.  If it was designed to
be programmed at runtime by the OS, then we'd probably call it "fpga",
but otherwise it should be named for what's inside it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
