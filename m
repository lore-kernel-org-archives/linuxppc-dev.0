Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18450.24995.98191.95351@cargo.ozlabs.ibm.com>
Date: Sat, 26 Apr 2008 08:56:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][WIP][PATCH] Add IRQSTACKS to ppc32
In-Reply-To: <21BCF98A-DE5B-4F5C-8A8B-EC2EB07458FE@kernel.crashing.org>
References: <Pine.LNX.4.64.0804240034160.23185@blarg.am.freescale.net>
	<20080425072332.GB23053@lst.de> <1209128614.5420.6.camel@pasglop>
	<21BCF98A-DE5B-4F5C-8A8B-EC2EB07458FE@kernel.crashing.org>
Cc: Christoph Hellwig <hch@lst.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> Do we think we want to poke Paul to get this in for v2.6.26 so we can  
> get it some more testing on all the ppc32 systems?

It's not going in 2.6.26, since it's a pretty substantial change and
it was first seen half-way through the merge window...

Paul.
