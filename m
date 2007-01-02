Return-Path: <mgreer@mvista.com>
Date: Tue, 2 Jan 2007 16:29:51 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: David Gibson <dgibson@ozlabs.org>
Subject: Re: libfdt - flat tree manipulation library
Message-ID: <20070102232951.GA19409@mag.az.mvista.com>
References: <20061127055905.GA6428@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061127055905.GA6428@localhost.localdomain>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 27, 2006 at 04:59:05PM +1100, David Gibson wrote:
> So, Mark Greer has already written some library functions for
> handling flat device trees, which are included in
> arch/powerpc/boot/flatdevtree.c (but could be used elsewhere).  For
> several reasons, I don't like the interface very much though.  So,
> here's my own somewhat different approach to a flat device tree
> library.  Read-only and some very limited write functions so far -
> more complete read-write support still in progress (some prototypes
> are there already).

Hi David.

I've been on other things for the last several weeks and haven't kept up
with all the volume on linuxppc-dev sooo this may be a stupid question...

Have you done any work integrating libfdt into the arch/powerpc/boot
yet?  If so, can you point me to whatever you have?

Thanks,

Mark
