Return-Path: <amodra@bigpond.net.au>
Received: from nschwmtas06p.mx.bigpond.com (nschwmtas06p.mx.bigpond.com
	[61.9.189.152]) by ozlabs.org (Postfix) with ESMTP id EDD3BDDE9E
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 15:33:36 +1000 (EST)
Date: Thu, 12 Jun 2008 15:03:35 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: linux-next: powerpc build failure
Message-ID: <20080612053335.GA22035@bubble.grove.modra.org>
References: <20080611192748.686236fd.sfr@canb.auug.org.au>
	<20080611095951.GB14033@elte.hu>
	<18512.32267.636550.47385@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18512.32267.636550.47385@cargo.ozlabs.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 12, 2008 at 11:38:19AM +1000, Paul Mackerras wrote:
> Direct unconditional branches, including procedure calls, can only
> reach +/- 32MB from the address of the branch on powerpc.  So if the
> image grows to more than 32MB of text there is a problem unless the
> linker is smart enough to insert trampolines.  I don't know whether
> GNU ld is that smart.

It is, but you need to pass --relax to enable generation of the
trampolines.

-- 
Alan Modra
Australia Development Lab, IBM
