Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 85DD7DDE1E
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 16:02:05 +1000 (EST)
Date: Mon, 5 May 2008 08:01:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: WARNING: mutexes are preferred for single holder semaphores
Message-ID: <20080505060154.GA12393@lst.de>
References: <20080504204104.7eea7618@lappy.seanm.ca>
	<18462.27991.229693.188377@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18462.27991.229693.188377@cargo.ozlabs.ibm.com>
Cc: Sean MacLennan <seanm@seanm.ca>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 05, 2008 at 12:13:43PM +1000, Paul Mackerras wrote:
> Sean MacLennan writes:
> 
> > This is a bit OT, but I got the warning in the subject from
> > checkpatch.pl for a piece of code. The code *is* using a mutex. Does it
> > actually mean I shouldn't use a mutex?
> 
> I don't require zero checkpatch warnings or errors on patches before I
> accept them.  If what checkpatch is saying is rubbish, just ignore it.

Current versions don't spew much rubbish anymore, and this one certainly
isn't.
