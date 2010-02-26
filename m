Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-01.bluehost.com (outbound-mail-01.bluehost.com
	[69.89.21.11]) by ozlabs.org (Postfix) with SMTP id 47CABB7D2A
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2010 10:43:56 +1100 (EST)
Date: Fri, 26 Feb 2010 15:44:25 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: John Linn <John.Linn@xilinx.com>
Subject: Re: Proposal to move PCI out of arch/powerpc and into drivers/of
Message-ID: <20100226154425.00dde291@jbarnes-piketon>
In-Reply-To: <27bab769-0788-4b48-96a7-ced65e40144c@SG2EHSMHS007.ehs.local>
References: <27bab769-0788-4b48-96a7-ced65e40144c@SG2EHSMHS007.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: devicetree-discuss@ozlabs.org, michal.simek@petalogix.com,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 26 Feb 2010 16:07:59 -0700
John Linn <John.Linn@xilinx.com> wrote:

> Hi all,
> 
> We are in the process of putting PCI/PCIe into the microblaze
> architecture.  
> 
> In order to not duplicate/fork the PCI code in Powerpc, we're
> proposing to move the PCI code from arch/powerpc into drivers/of such
> that it would be common code for Powerpc and MicroBlaze.
> 
> This would be the 1st part of a refactoring that would occur with the
> PCI code.
> 
> Ben H., would you mind if that happened (move arch/powerpc/kernel/pci*
> to drivers/of/*)?

Dave and Ben have been talking about this for awhile; seems like a good
excuse to do it.  IIRC they had even thought about just dumping the
code directly into drivers/pci so that API updates won't get missed...

-- 
Jesse Barnes, Intel Open Source Technology Center
