Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <4616BA1A.3090309@am.sony.com>
References: <1175208237.3122.78.camel@pmac.infradead.org>
	<4616BA1A.3090309@am.sony.com>
Content-Type: text/plain
Date: Sat, 07 Apr 2007 08:34:11 +1000
Message-Id: <1175898852.7407.11.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-04-06 at 14:22 -0700, Geoff Levand wrote:

> I committed a change that pulls the command line out of the incompatible DT and
> merges it with the built-in DT.
> 
>   http://git.kernel.org/?p=linux/kernel/git/geoff/ps3-linux-patches.git;a=blob;f=ps3-hacks/ps3-no-bootwrapper-hack.diff

A bit yukcy but I suppose it'll do for now ... though this shouldn't be
kept as a long term approach unless there's some versionning or such.
You also need to pull the initrd btw.

Ben.
