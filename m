Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D34A1DDF42
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 19:57:30 +1000 (EST)
Date: Mon, 21 Apr 2008 11:57:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: Add compat handler for PTRACE_GETSIGINFO
Message-ID: <20080421095719.GA9504@lst.de>
References: <je1w51ak2e.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <je1w51ak2e.fsf@sykes.suse.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 19, 2008 at 06:25:13PM +0200, Andreas Schwab wrote:
> Current versions of gdb require a working implementation of
> PTRACE_GETSIGINFO for proper watchpoint support.  Since struct siginfo
> contains pointers it must be converted when passed to a 32-bit debugger.

Roland just posted a patch to do this in generic code.
