Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC: PATCH 08/13] powerpc/476: define specific cpu table
	entry for DD1 and DD1.1 cores
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20100301202409.GB8963@zod.rchland.ibm.com>
References: <20100301191255.20987.84668.sendpatchset@norville.austin.ibm.com>
	<20100301191351.20987.49730.sendpatchset@norville.austin.ibm.com>
	<20100301202409.GB8963@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Mon, 01 Mar 2010 17:43:36 -0600
Message-Id: <1267487016.26041.58.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>, Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-03-01 at 15:24 -0500, Josh Boyer wrote:
> On Mon, Mar 01, 2010 at 02:13:52PM -0500, Dave Kleikamp wrote:
> >powerpc/476: define specific cpu table entry for DD1 and DD1.1 cores
> >
> >From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >
> >There are still some unstable bits on the DD1 and DD1.1 cores.  Don't use
> >the FPU or the tlbivax operation.  Define CPU_FTR_476_DD1 and
> >CPU_FTR_476_DD1_1 for additional workarounds in later patches.
> >
> >The DD1 core requires workarounds triggered by both CPU_FTR_476_DD1
> >and CPU_FTR_476_DD1_1.  the DD1.1 core only needs CPU_FTR_476_DD1_1
> >defined.
> 
> DD1, DD1.1, and all others have the same PVR value?  How do you tell which
> core version you have?

I seemed to have lost the change to the DD1.1 PVR value.  I originally
coded it this way while I was waiting to find out what it was.  DD1.1 is
0x11A52040.  I don't know a value for the future versions, so that will
have to be filled in later.  Actually, I should probably use 0x11A52000,
since that's what's defined in reg.h.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center
