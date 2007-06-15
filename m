Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 38FD0DDFC4
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 07:19:11 +1000 (EST)
Date: Fri, 15 Jun 2007 14:20:16 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: MPC7450 L2 HW cache flush feature utilization
Message-ID: <20070615212016.GB18055@mag.az.mvista.com>
References: <1181729973.25586.31.camel@dolphin.spb.rtsoft.ru>
	<db0d38e5b5e1a9a3a7fe35d25ebd357a@kernel.crashing.org>
	<467176EB.7060404@ru.mvista.com>
	<6c416bf9f79a648fc82f64619aca86de@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6c416bf9f79a648fc82f64619aca86de@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 15, 2007 at 10:14:24AM +0200, Segher Boessenkool wrote:

> > I've double checked this. All processors considered 7450 in the kernel 
> > are covered by MPC7450 RISC Microprocessor Family Reference Manual 
> > where hardware cache flushing procedure is described.
> 
> Nice.  Now all that remains to be done is for the patch to
> be tested on actual hardware for at least a few of those
> other CPUs.  Any volunteers?

I just booted & played around on a prpmc2800e (7447A, 512MB) with
this patch and it seemed to work fine.

I *may* have some old sandpoint 745x modules that still work but
I'll have to get the sandpoint working in arch/powerpc again.
I'll try to get to that in a week or so.

Mark
