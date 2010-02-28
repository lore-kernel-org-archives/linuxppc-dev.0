Return-Path: <benh@kernel.crashing.org>
Subject: Re: Proposal to move PCI out of arch/powerpc and into drivers/of
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
In-Reply-To: <20100226154425.00dde291@jbarnes-piketon>
References: <27bab769-0788-4b48-96a7-ced65e40144c@SG2EHSMHS007.ehs.local>
	<20100226154425.00dde291@jbarnes-piketon>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 28 Feb 2010 11:33:06 +1100
Message-ID: <1267317186.23523.1860.camel@pasglop>
Mime-Version: 1.0
Cc: devicetree-discuss@ozlabs.org, michal.simek@petalogix.com,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, John Linn <John.Linn@xilinx.com>,
	John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-02-26 at 15:44 -0800, Jesse Barnes wrote:
> 
> Dave and Ben have been talking about this for awhile; seems like a
> good
> excuse to do it.  IIRC they had even thought about just dumping the
> code directly into drivers/pci so that API updates won't get
> missed... 

Depends which part. Not -all- of our PCI code as John seems to want.

The bits that generate PCI devices from the device-tree, for sure,
though again, even there, there are quite a few dependencies on
constructs and data structures that are powerpc specific, or even ppc64
specific in some cases, and that would have to be cleaned up and/or
abstracted first.

Cheers,
Ben.
