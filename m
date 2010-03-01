Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Mon, 1 Mar 2010 15:24:09 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC: PATCH 08/13] powerpc/476: define specific cpu table
	entry for DD1 and DD1.1 cores
Message-ID: <20100301202409.GB8963@zod.rchland.ibm.com>
References: <20100301191255.20987.84668.sendpatchset@norville.austin.ibm.com>
	<20100301191351.20987.49730.sendpatchset@norville.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100301191351.20987.49730.sendpatchset@norville.austin.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>, Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 01, 2010 at 02:13:52PM -0500, Dave Kleikamp wrote:
>powerpc/476: define specific cpu table entry for DD1 and DD1.1 cores
>
>From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
>There are still some unstable bits on the DD1 and DD1.1 cores.  Don't use
>the FPU or the tlbivax operation.  Define CPU_FTR_476_DD1 and
>CPU_FTR_476_DD1_1 for additional workarounds in later patches.
>
>The DD1 core requires workarounds triggered by both CPU_FTR_476_DD1
>and CPU_FTR_476_DD1_1.  the DD1.1 core only needs CPU_FTR_476_DD1_1
>defined.

DD1, DD1.1, and all others have the same PVR value?  How do you tell which
core version you have?

josh
