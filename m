Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17652.55334.554969.284398@cargo.ozlabs.ibm.com>
Date: Wed, 30 Aug 2006 10:13:26 +1000
From: Paul Mackerras <paulus@samba.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: undefined reference to pci_io_base
In-Reply-To: <44F4D458.7030707@am.sony.com>
References: <44F47ABE.7080602@am.sony.com>
	<17652.49904.419167.448821@cargo.ozlabs.ibm.com>
	<20060829232026.GC27372@austin.ibm.com>
	<44F4D458.7030707@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand writes:

> I found the same, but was thinking
> 
> #if defined(CONFIG_ISA) && !defined(__mc68000__)
> 
> So it is only built when CONFIG_ISA=y.  Is there any
> reason to always have it whit PCI?

It's occasionally useful with PCI && !ISA.  It's pretty useless with
!PCI && !ISA.

> Paul, can I send you that fix, or should I send it to
> someone else?

Send it to Andrew Morton.

Paul.
