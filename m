Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC:PATCH 00/03] powerpc: Expose BookE debug registers
	through extended ptrace interface
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <ABDB7BBD-AFF2-4CAD-94E0-4A711FB7919B@kernel.crashing.org>
References: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
	<ABDB7BBD-AFF2-4CAD-94E0-4A711FB7919B@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 18 Jan 2010 16:41:00 -0600
Message-Id: <1263854460.27291.48.camel@norville.austin.ibm.com>
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

On Thu, 2009-12-10 at 20:45 -0600, Kumar Gala wrote:

> What do we do in EDM mode?  We need a flag somewhere to determine if
> HW supports conveying DBCR0[EDM] and if it does which of the ptrace
> calls fails?

I really don't have a good answer to this.  I'm open to any and all
advice.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center
