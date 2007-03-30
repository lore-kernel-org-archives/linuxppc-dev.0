Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <460D4BC3.8030805@am.sony.com>
Date: Fri, 30 Mar 2007 10:41:23 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
References: <1175208237.3122.78.camel@pmac.infradead.org>
In-Reply-To: <1175208237.3122.78.camel@pmac.infradead.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse wrote:
> The old 2.6.16 kernel handled memory statically and it was shown in the
> device tree. The current kernel deals with the hypervisor and hotplugs
> the memory, so we should just ignore anything that's reported in the
> device-tree. This enables the current kernel to be booted from 2.6.16
> without evil hacks in head_64.S to override the device-tree.

The proper way is to parse out just the command line from the incompatible
DT, and use that with the new DT supplied by the bootwrapper.  I planed
to do that in my bootwrapper, but haven't coded it yet.

-Geoff
