Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C5E9A2BDD7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Oct 2004 09:34:35 +1000 (EST)
Date: Tue, 12 Oct 2004 16:34:32 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: jonathan@jonmasters.org
Message-ID: <20041012233432.GB24352@gate.ebshome.net>
References: <1e44ebcf04101214247d3072b6@mail.gmail.com>
	<20041012213634.GA4936@gate.ebshome.net>
	<35fb2e590410121603624c27a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35fb2e590410121603624c27a2@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
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

On Wed, Oct 13, 2004 at 12:03:21AM +0100, Jon Masters wrote:
> On Tue, 12 Oct 2004 14:36:34 -0700, Eugene Surovegin <ebs@ebshome.net> wrote:
> 
> > Did you use ioremap to get valid kernel virtual address for your
> > device registers? You generally cannot just use physical address to
> > access device from the device driver.
> 
> Possibly also use io_block_mapping on ppc to map a block of IO memory
> before ioremapping.

Yes, this is possible but considered obsoleted and not-recommended way 
of accessing device registers.

--
Eugene
