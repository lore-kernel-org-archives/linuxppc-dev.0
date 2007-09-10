Return-Path: <b07421@freescale.com>
Date: Mon, 10 Sep 2007 09:30:06 -0500
From: Scott Wood <scottwood@freescale.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 08/10] bootwrapper: Add a firmware-independent "raw"
	target.
Message-ID: <20070910143006.GD21670@ld0162-tx32.am.freescale.net>
References: <20070907005803.GJ26079@localhost.localdomain>
	<d16e868937a1f77cbf080754f5742ad9@bga.com>
	<20070910142513.GB21670@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070910142513.GB21670@ld0162-tx32.am.freescale.net>
Cc: ppcdev <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 10, 2007 at 09:25:13AM -0500, Scott Wood wrote:
> > (5) space below load to decompress vmlinux (no vmlinux_alloc to 
> > fallback to malloc)
> > (6) all space above load address available to hold malloc region
> > (7) for console output (or input) from wrapper, on most cpus, some 
> > magic setup
> 
> For #5, I really need to get around to implementing setting the load
> address at build-time based on the size of vmlinux...

Actually, this isn't needed for raw images -- you can just load them
wherever you want (and thus yes, it should be documented).  cuboot needs
it, though.

-Scott
