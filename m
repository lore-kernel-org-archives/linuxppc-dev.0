Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AC59DDDE16
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 00:24:25 +1100 (EST)
Message-Id: <C608AAD4-29F7-4D5D-AA85-3B28CCCAADE5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Matthew Wilcox <matthew@wil.cx>
In-Reply-To: <20071206081628.GA15868@parisc-linux.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] pci: Fix bus resource assignment on 32 bits with 64b
	resources
Date: Thu, 6 Dec 2007 07:24:12 -0600
References: <20071205064116.D849BDE10A@ozlabs.org>
	<1196911347.7033.15.camel@pasglop>
	<20071206063940.GA16474@kroah.com>
	<1196927934.7033.39.camel@pasglop>
	<20071206081628.GA15868@parisc-linux.org>
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 6, 2007, at 2:16 AM, Matthew Wilcox wrote:

> On Thu, Dec 06, 2007 at 06:58:54PM +1100, Benjamin Herrenschmidt  
> wrote:
>> I was just hoping somebody had a better idea, like a way to add a new
>> format specifier to printk without losing gcc type checking :-)
>
> It's been discussed before.  Some of the solutions discussed:
>
> - Add something like PRI_RES which can be concatenated into a printk.
>   Ugly.
> - Patch gcc to allow user-definable types.  I think OpenBSD has a  
> patch
>   for this.  Then we have to get that patch propagated to all the
>   people who compile the kernel.  Unappetising.
> - Disable gcc's printk checking, teach sparse to typecheck printk.
>   Most people don't run sparse yet.

How does gcc deal with glibc extension to allow people to add their  
own specifiers?

http://www.gnu.org/software/libc/manual/html_node/Customizing-Printf.html

- k
