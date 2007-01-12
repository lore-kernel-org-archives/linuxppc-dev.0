Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D4E10DDEFD
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 11:23:28 +1100 (EST)
Date: Thu, 11 Jan 2007 18:27:12 -0600
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 4/7] MPIC MSI allocator
Message-ID: <20070112002712.GA15117@lixom.net>
References: <1168514716.63474.857278133999.qpush@cradle>
	<20070111112504.37999DDF3E@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070111112504.37999DDF3E@ozlabs.org>
From: Olof Johansson <olof@lixom.net>
Cc: Greg Kroah-Hartman <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 11, 2007 at 10:25:21PM +1100, Michael Ellerman wrote:
> To support MSI on MPIC we need a way to reserve and allocate hardware irq
> numbers, this patch implements an allocator for that.
> 
> Updated to only do dogy-U3-fallback-hacks on U3, all other platforms must
> define a "msi-ranges" property on their MPIC node for MSI to work.

The msi-ranges spec isn't documented anywhere besides the code where it's
used. Please add it to Documentation/powerpc/booting-without-of.txt too.


-Olof
