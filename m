Return-Path: <bauerman@br.ibm.com>
From: Thiago Jung Bauermann <bauerman@br.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC:PATCH 00/03] powerpc: Expose BookE debug registers through
	extended ptrace interface
Date: Fri, 11 Dec 2009 18:07:56 -0200
References: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
	<F0B42818-1EE1-47EE-B2F3-B7529B2E13C8@kernel.crashing.org>
	<1260498456.4329.8.camel@norville.austin.ibm.com>
In-Reply-To: <1260498456.4329.8.camel@norville.austin.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <200912111807.56262.bauerman@br.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Sergio Durigan Junior <sergiodj@br.ibm.com>,
	Torez Smith <torez@us.ibm.com>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri 11 Dec 2009 00:27:36 Dave Kleikamp wrote:
> On Thu, 2009-12-10 at 20:23 -0600, Kumar Gala wrote:
> > On Dec 10, 2009, at 9:57 AM, Dave Kleikamp wrote:
> > > #define PPC_DEBUG_FEATURE_INSN_BP_RANGE		0x1
> > > #define PPC_DEBUG_FEATURE_INSN_BP_MASK		0x2
> > > #define PPC_DEBUG_FEATURE_DATA_BP_RANGE		0x4
> > > #define PPC_DEBUG_FEATURE_DATA_BP_MASK		0x8
> >
> > Is GDB smart enough to deal w/no condition_regs?  On some Book-E
> > devices we have 2 IACs, 2 DACs, and 0 DVCs.  Does it need to be in the
> > features?
> 
> I had discussed it with the gdb team.  I could easily add a feature
> flag, but it would be equivalent to num_condition_regs > 0.  I don't
> have a strong opinion either way.

The current GDB code we have here uses num_condition_regs > 0 to discover if 
DVCs are supported, so a PPC_DEBUG_FEATURE constant for that is redundant 
IMHO.
-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
