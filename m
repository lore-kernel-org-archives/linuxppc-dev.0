Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: fix userspace build of ptrace.h
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1273390060.4861.230.camel@pasglop>
References: <4BE5C203.6060509@varma-el.com>
	<1273375269.5312.4.camel@norville.austin.ibm.com>
	<20100509065931.GA6633@merkur.ravnborg.org>
	<1273390060.4861.230.camel@pasglop>
Content-Type: text/plain
Date: Mon, 10 May 2010 09:10:50 -0500
Message-Id: <1273500650.5317.4.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Andrey Volkov <avolkov@varma-el.com>, Sam Ravnborg <sam@ravnborg.org>,
	LKML <linux-kernel@vger.kernel.org>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2010-05-09 at 17:27 +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2010-05-09 at 08:59 +0200, Sam Ravnborg wrote:
> > >From ff056c080d2b0b93bac07ad71125fee701919f5e Mon Sep 17 00:00:00 2001
> > From: Sam Ravnborg <sam@ravnborg.org>
> > Date: Sun, 9 May 2010 08:52:31 +0200
> > Subject: [PATCH] powerpc: fix userspace build of ptrace.h
> > 
> > Build of ptrace.h failed for assembly because it
> > pulls in stdint.h.
> > Use exportable types (__u32, __u64) to avoid the dependency
> > on stdint.h.
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Andrey Volkov <avolkov@varma-el.com>
> > Cc: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> > 
> > A better fix is to remove the use of stdint like the following patch does.
> > Note - I have not even build tested this patch!
> 
> Ack, thanks, I'll test and apply.

Acked-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

-- 
Dave Kleikamp
IBM Linux Technology Center
