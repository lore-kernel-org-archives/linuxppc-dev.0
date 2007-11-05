Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Don't force alignment of cell list data 
In-Reply-To: Your message of "Fri, 02 Nov 2007 16:54:26 +1100."
	<20071102055426.GN19839@localhost.localdomain>
References: <20071102055426.GN19839@localhost.localdomain> 
Date: Mon, 05 Nov 2007 08:59:44 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Ip3QW-0007lf-72@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> At present, defining a property as, say:
> 	foo = [abcd], <ffffffff>;
> 
> Will cause dtc to insert 2 bytes of zeros between the abcd and the
> ffffffff, to align the cell form data.
> 
> Doing so seemed like a good idea at the time, but I don't believe
> there are any users who actually rely on this behaviour.  Segher
> claims that OF has some defined bindings which include properties an
> unaligned subsection of which is interpreted as 32-bit ints (i.e. like
> cell data).
> 
> Worse, this alignment will cause nothing but pain when we add
> expression support to dtc (when celldata is included in a larger
> bytestring expession, we won't know the size of the preceding chunk of
> the expression until it's evaluated, so we would have to carry
> alignment fixup information right through the expression evaluation
> process).
> 
> Therefore, this patch kills off this alignment behaviour.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
