Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Improve and better integrate dtc and libfdt Makefiles 
In-Reply-To: Your message of "Tue, 26 Jun 2007 12:45:51 +1000."
	<20070626024551.GG4383@localhost.localdomain>
References: <20070626024551.GG4383@localhost.localdomain> 
Date: Mon, 25 Jun 2007 21:51:26 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1I319K-0005YX-BT@jdl.com>
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
> This patch substantially revamps the dtc Makefiles, in particular
> better integrating the Makefile for dtc proper with the Makefiles
> imported from libfdt for libfdt and the shared testsuite.  Notable
> changes:
> 	- No recursive make calls.  Instead subsidiary Makefiles are
> included into the top-level Makefile so we get a complete dependency
> information.
> 	- Common pattern rules, CFLAGS etc. shared between dtc, libfdt
> and testsuite, rather than separate copies.
> 	- Vaguely Kbuild-like non-verbose mode used by default, which
> makes warnings more prominent.
> 	- libfdt Makefile consists only of variable definitions and
> helper rules, to make it more easily embeddable into other Makefile
> systems.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

I like.

Applied.

Thanks!
jdl
