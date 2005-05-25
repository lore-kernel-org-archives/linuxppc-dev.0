Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <1116984651.6395.60.camel@gaston>
References: <1116984651.6395.60.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2d61cb60140e879d0c8d46e7f51a9f56@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 24 May 2005 21:17:35 -0500
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org
Subject: Re: RFC: Deprecating io_block_mapping
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On May 24, 2005, at 8:30 PM, Benjamin Herrenschmidt wrote:

> As the subject says ... it's the source of endless headaches, is used 
> in
> a way that often prevents moving TASK_SIZE freely, etc etc etc...
>
> What are the good and unavoidable uses of it currently that cannot be
> replaced by some sort of ioremap ?

Do you propose to fixup ioremap to allocate large page resources (BATs 
and CAMs) going forward?

> (Note that if the answer to the above is: page tables exist too late, I
> already have a reply: our initialisations happen too early, let's move
> things around so that ioremap is useable... pretty much everything
> needed to setup kernel page tables & have working ioremap can be done
> without any HW device access so ...)

Do you have any proposed solution for early console access?  I'm 
guessing that most of the need for early access is for some sort of 
console (serial) for early debug output.

Also does this mean we would drop ppc_md.setup_io_mappings() complete?

- kumar
