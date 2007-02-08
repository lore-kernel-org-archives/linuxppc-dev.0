Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [dtc] Allow references to labels 
In-Reply-To: Your message of "Wed, 07 Feb 2007 14:29:07 +1100."
	<20070207032907.GE23870@localhost.localdomain>
References: <20070207032907.GE23870@localhost.localdomain> 
Date: Thu, 08 Feb 2007 17:28:13 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HFIgX-0003b2-8u@jdl.com>
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
> dtc allows nodes to have labels, which at present are just re-emitted
> as symbols at the appropriate places when using asm-mode output.  It
> also allows "references" where the notation &/path/to/node in a cell
> list will be replaced with the phandle of the referenced node.
> 
> This patch extends the reference syntax to allow references to labels
> instead of just full device paths.  This allows nodes deep within the
> tree to be referenced with a shorter more convenient name.  References
> to labels are distinguished from reference to paths by the fact that
> paths must start with a /, but labels can never start with a /.
> 
> Signed-off-by: David Gibson <dwg@au1.ibm.com>
> 
> Index: dtc/livetree.c

Applied.

Thanks,
jdl
