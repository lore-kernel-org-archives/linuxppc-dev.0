Return-Path: <dgibson@ozlabs.org>
Date: Sat, 20 Oct 2007 17:11:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Leisner, Martin" <Martin.Leisner@xerox.com>
Subject: Re: embedded a default dtb in the kernel (was merge dtc)
Message-ID: <20071020071122.GC26642@localhost.localdomain>
References: <556445368AFA1C438794ABDA8901891C075945FD@USA0300MS03.na.xerox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <556445368AFA1C438794ABDA8901891C075945FD@USA0300MS03.na.xerox.net>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 19, 2007 at 02:30:28PM -0400, Leisner, Martin wrote:
> Is there a way to embed a default dtb into the kernel?
> When I build a kernel, I want to embed a dtb into it --
> so I don't have to deal with the headaches of finding the
> right file to match the right board (its always easier to
> deal with 1 file than 2).

You can't embed a dtb in the vmlinux, but zImages routinely contain an
embedded dtb.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
