Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18271.20785.163232.915724@cargo.ozlabs.ibm.com>
Date: Wed, 12 Dec 2007 14:10:41 +1100
From: Paul Mackerras <paulus@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 2.6.25 5/5] powermac: proper sleep management
In-Reply-To: <1197383159.4037.19.camel@johannes.berg>
References: <20071211142122.966506000@sipsolutions.net>
	<1197383159.4037.19.camel@johannes.berg>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg writes:

> This adds platform_suspend_ops for PMU based machines, directly in
> the PMU driver. This finally allows suspending via /sys/power/state
> on powerbooks.

Does this depend on your Kconfig patches?  You add references to
CONFIG_SUSPEND but I don't see that symbol being added to any Kconfig
files in this series of 5 patches.

If there is that dependency then it's a bit difficult for me to put
this patch into powerpc.git, since your Kconfig patches are going in
via other maintainers, and powerpc.git with this patch but without the
Kconfig patches would be broken.

Paul.
