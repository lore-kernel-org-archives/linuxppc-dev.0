Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17985.26509.807018.401277@cargo.ozlabs.ibm.com>
Date: Wed, 9 May 2007 16:17:49 +1000
From: Paul Mackerras <paulus@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] swsusp: introduce register_nosave_region_late
In-Reply-To: <1178616229.18162.40.camel@johannes.berg>
References: <1178616229.18162.40.camel@johannes.berg>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg writes:

> This patch introduces a new register_nosave_region_late function that
> can be called from initcalls when register_nosave_region can no longer
> be used because it uses bootmem.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ---
> Paul, I see you merged the suspend to disk for G5 patches, but this one
> is required for it to build. Rafael said that we should merge it with
> the user, since our code is the only user right now I take it that means
> it should go through the powerpc tree.

OK, but the patch doesn't apply against Linus' tree.  It has no
mention of register_nosave_region in include/linux/suspend.h, for
instance.  Which tree is this patch against?

Paul.
