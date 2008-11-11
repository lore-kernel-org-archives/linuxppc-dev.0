Return-Path: <dgibson@ozlabs.org>
Date: Wed, 12 Nov 2008 09:39:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Building dtc etc. for packaging
Message-ID: <20081111223903.GB16405@yookeroo.seuss>
References: <4919C115.8040107@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4919C115.8040107@genesi-usa.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 11, 2008 at 11:29:57AM -0600, Matt Sealey wrote:
> For some of what we're doing with SUSE now I've determined we should really
> be packaging the device tree compiler (and libfdt) so that we can install and
> script it, along with some other stuff from U-Boot (not for this mail).
>
> I was wondering if the recommended way would be to use the dtc found in
> the kernel-source or to use the git repo at git.jdl.com to grab it and
> build it. The one in the kernel is seemingly impossible to build without
> some tweaking around (I can't find a target for make that does it) so
> I also wonder about a hint here on what to do to create it from the
> kernel source so we can pull it out for a local system install.

Use the tree from jdl.org.  Either the git tree if you really need an
up-to-date snahpshot, or one of the actual release tarballs.

Apart from being the official upstream version, the tree there has
make install targets, the full testsuite and other conveniences which
will help for packaging.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
