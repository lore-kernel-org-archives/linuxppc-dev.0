Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Forgot one function when cleaning the namespace 
In-reply-to: <20080729045122.GC19856@yookeroo.seuss> 
References: <20080729045122.GC19856@yookeroo.seuss>
Date: Thu, 31 Jul 2008 10:38:56 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1KOaEy-0006M6-F2@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> In commit b6d80a20fc293f3b995c3ce1a6744a5574192125, we renamed all
> libfdt functions to be prefixed with fdt_ or _fdt_ to minimise the
> chance of collisions with things from whatever package libfdt is
> embedded in, pulled into the libfdt build via that environment's
> libfdt_env.h.
> 
> Except... I missed one.  This patch applies the same treatment to
> _stringlist_contains().  While we're at it, also make it static since
> it's only used in the same file.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
