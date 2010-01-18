Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC:PATCH 02/03] powerpc: Add definitions for Debug Registers
	on BookE Platforms
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20091210170741.GU2937@zod.rchland.ibm.com>
References: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
	<20091210155721.6697.40863.sendpatchset@norville.austin.ibm.com>
	<20091210170741.GU2937@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Mon, 18 Jan 2010 16:07:34 -0600
Message-Id: <1263852454.27291.21.camel@norville.austin.ibm.com>
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

On Thu, 2009-12-10 at 12:07 -0500, Josh Boyer wrote:
> On Thu, Dec 10, 2009 at 01:57:21PM -0200, Dave Kleikamp wrote:

> >+	/*
> >+	 * The stored value of the DBSR register will be the value at the
> >+	 * last debug interrupt. This register can only be read from the
> >+	 * user (will never be written to) and has value while helping to
> >+	 * describe the reason for the last debug trap.  Torez
> >+	 */
> >+	unsigned long	dbsr;
> >+	/*
> >+	 * The following will contain addresses used by debug applications
> >+	 * to help trace and trap on particular address locations.
> >+	 * The bits in the Debug Control Registers above help define which
> >+	 * of the following registers will contain valid data and/or addresses.
> >+	 */
> >+	unsigned long	iac1;
> >+	unsigned long	iac2;
> >+	unsigned long	iac3;
> >+	unsigned long	iac4;
> >+	unsigned long	dac1;
> >+	unsigned long	dac2;
> >+	unsigned long	dvc1;
> >+	unsigned long	dvc2;
> > #endif
> 
> Without digging much, I'm wondering if we could just use a pointer to a debug
> register structure here instead of growing struct thread more.

I didn't do this (yet).  I'm not sure if it is worth the trouble.  Don't
hesitate to change my mind on this.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center
