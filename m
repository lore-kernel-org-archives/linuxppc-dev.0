Return-Path: <jcm@jonmasters.org>
Received: from smtp.mailbox.co.uk (smtp.mailbox.net.uk [195.82.125.32])
	by ozlabs.org (Postfix) with ESMTP id EB8DC2BDA1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 08:27:05 +1000 (EST)
Date: Wed, 13 Oct 2004 19:00:20 +0100
From: Jon Masters <jonathan@jonmasters.org>
To: jonathan@jonmasters.org, Rupesh S <rupesh.sugathan@gmail.com>,
	linuxppc-embedded@ozlabs.org
Message-ID: <20041013180020.GC29369@apogee.jonmasters.org>
References: <1e44ebcf04101214247d3072b6@mail.gmail.com>
	<20041012213634.GA4936@gate.ebshome.net>
	<35fb2e590410121603624c27a2@mail.gmail.com>
	<20041012233432.GB24352@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041012233432.GB24352@gate.ebshome.net>
Sender: Jon Masters <jcm@jonmasters.org>
Cc: 
Subject: Re: PPC kernel hangs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Oct 12, 2004 at 04:34:32PM -0700, Eugene Surovegin wrote:
> On Wed, Oct 13, 2004 at 12:03:21AM +0100, Jon Masters wrote:
> > On Tue, 12 Oct 2004 14:36:34 -0700, Eugene Surovegin <ebs@ebshome.net> wrote:
> > 
> > > Did you use ioremap to get valid kernel virtual address for your
> > > device registers? You generally cannot just use physical address to
> > > access device from the device driver.
> > 
> > Possibly also use io_block_mapping on ppc to map a block of IO memory
> > before ioremapping.
> 
> Yes, this is possible but considered obsoleted and not-recommended way 
> of accessing device registers.

I realised that after I said it, old habbit.

Jon.
