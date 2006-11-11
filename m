Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CCD7C67FAA
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 22:24:09 +1100 (EST)
Date: Sat, 11 Nov 2006 12:24:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
Message-ID: <20061111112403.GC24288@lst.de>
References: <4554DACB.8060809@am.sony.com> <20061111112125.GA24288@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061111112125.GA24288@lst.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Nov 11, 2006 at 12:21:25PM +0100, Christoph Hellwig wrote:
> On Fri, Nov 10, 2006 at 12:02:19PM -0800, Geoff Levand wrote:
> > This adds the core platform support for the PS3 game console and other
> > platforms using the PS3 Platform hypervisor.
> 
> Please give the port a less confusing name.  I'd expect platforms/ps3
> to be the bare metal port once people have revere-engineered the
> hardware, so your crappy hipervisor code should make it very clear what
> it is.  sonyhv or ps3hv would suite I think.

Any while we're at it it probably shouldn't be it's own directory
under platforms, as platforms/cell contains a lot of generic cell
stuff.  We should rather have platforms/cell for all cell stuff
and then sub-platform prefixed bits.  Especially as e.g. the cpbw and
native cell port will probably share a lot of code.
