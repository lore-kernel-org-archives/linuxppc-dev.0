Return-Path: <dgibson@ozlabs.org>
Date: Fri, 22 Feb 2008 16:34:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Add support for binary includes.
Message-ID: <20080222053450.GH3064@localhost.localdomain>
References: <20080220191941.GA2062@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080220191941.GA2062@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 20, 2008 at 01:19:41PM -0600, Scott Wood wrote:
> A property's data can be populated with a file's contents
> as follows:
> 
> node {
> 	prop = /incbin/("path/to/data");
> };
> 
> A subset of a file can be included by passing start and size parameters.
> For example, to include bytes 8 through 23:
> 
> node {
> 	prop = /incbin/("path/to/data", 8, 16);
> };
> 
> As with /include/, non-absolute paths are looked for in the directory
> of the source file that includes them.

I still dislike the syntax, but haven't thought of a better one yet.
There are some issues with the implementation too, but I've been a bit
too busy with ePAPR stuff to review properly.

Soon, I hope.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
