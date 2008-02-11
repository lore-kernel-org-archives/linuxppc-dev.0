Return-Path: <dgibson@ozlabs.org>
Date: Tue, 12 Feb 2008 10:54:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Could the DTS experts look at this?
Message-ID: <20080211235409.GB18348@localhost.localdomain>
References: <47ACE630.8090101@pikatech.com> <200802100647.56590.arnd@arndb.de>
	<47B08C76.3000009@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47B08C76.3000009@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 11, 2008 at 11:57:10AM -0600, Timur Tabi wrote:
> Arnd Bergmann wrote:
> 
> > Maybe we can introduce a more generic way of having conditional
> > device nodes in the tree that get knocked out in the boot wrapper.
> 
> I've been thinking about doing just this for quite some time now.  I've had a 
> few informal discussions without people about.
> 
> One idea is to allow attaching simple conditional expressions (like
> X is <, =, or > than Y) to a node.  It is the responsibility of the
> code that parses the device tree to assign values to X and Y.  For
> instance, they could be the names of U-Boot environment variables.
> If the expression is false, then the node is removed (or ignored)
> from the device tree.  If it's true, then it's kept in.

In the binary tree representation itself?  No way.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
