Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC:PATCH 00/03] powerpc: Expose BookE debug registers
	through extended ptrace interface
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1263854072.27291.47.camel@norville.austin.ibm.com>
References: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
	<F0B42818-1EE1-47EE-B2F3-B7529B2E13C8@kernel.crashing.org>
	<1263854072.27291.47.camel@norville.austin.ibm.com>
Content-Type: text/plain
Date: Tue, 02 Feb 2010 20:03:34 -0600
Message-Id: <1265162614.17758.28.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Sergio Durigan Junior <sergiodj@br.ibm.com>,
	Torez Smith <torez@us.ibm.com>,
	Thiago Jung Bauermann <bauerman@br.ibm.com>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-01-18 at 16:34 -0600, Dave Kleikamp wrote:
> On Thu, 2009-12-10 at 20:23 -0600, Kumar Gala wrote:

> > Is GDB smart enough to deal w/no condition_regs?  On some Book-E
> > devices we have 2 IACs, 2 DACs, and 0 DVCs.  Does it need to be in the
> > features?
> 
> I wasn't aware that the bookE devices had varying numbers of these
> registers.  I guess I will have to make it a runtime option.

Kumar,

Can you tell me which bookE processors have 2 IAC's, and which have no
DVC's?

I think we still may be able to make these compile-time options as long
no two cpus that run on the same binary kernel vary in the number of
registers.  Right now I know the 403 only has 2 IAC's, and I don't
intend to expose the DVC's for the 40x processors anyway.

If they don't need to be run-time configurable, I think it would be
cleaner to define the number of each type of register in CONFIG_ flags
and put the logic into the Kconfig files.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center
