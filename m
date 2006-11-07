Return-Path: <mporter@gate.crashing.org>
Date: Tue, 7 Nov 2006 09:47:11 -0600
From: Matt Porter <mporter@embeddedalley.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/1]  PPC32 : Huge-page support for ppc440
Message-ID: <20061107154711.GA25499@gate.crashing.org>
References: <454FC362.9070608@linux.vnet.ibm.com>
	<1162864834.3809.21.camel@zod.rchland.ibm.com>
	<1162866287.28571.392.camel@localhost.localdomain>
	<ada1wogj5s0.fsf@cisco.com>
	<1162871122.28571.396.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1162871122.28571.396.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Roland Dreier <rdreier@cisco.com>,
	Edi Shmueli <edi@linux.vnet.ibm.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 07, 2006 at 02:45:22PM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2006-11-06 at 19:26 -0800, Roland Dreier wrote:
> >  > Also, while it's great to have somebody do this work, I doubt there is
> >  > much interest in merging it for arch/ppc... 
> > 
> > On that subject, what's the latest on moving ppc4xx to arch/powerpc?
> > At the kernel summit you told me to chill out and wait, but I'll
> > repeat my offer to help out....
> 
> Well, I told you that Matt Porter was about to do it :-) Now I haven't
> heard from him since. Feel free to jump in, just make sure you keep in
> sync with Josh and Matt.

Er, wait a minute. :) I did some work then got busy again. I handed my
starting point stuff to Josh who has been continuing on with some work.
So there is progress happening there on the basic enablement, that is,
outside of your contributions on mmio dcr handling etc.

-Matt
