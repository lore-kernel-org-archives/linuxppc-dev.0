Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id B8936DDF1E
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 14:32:29 +1100 (EST)
Date: Wed, 26 Mar 2008 22:41:03 -0500
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] Remove CONFIG_PCI_LEGACY from pasemi_defconfig
Message-ID: <20080327034103.GA31504@lixom.net>
References: <20080327142743.82c4f0fb.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080327142743.82c4f0fb.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Thu, Mar 27, 2008 at 02:27:43PM +1100, Stephen Rothwell wrote:

> Olof,  you should review this carefully to see if anything got turned off
> that you need (e.g. CONFIG_MTD_NAND_PASEMI) or turned on that you don't
> want (e.g. "Conflicting RTC option has been selected, check GEN_RTC and
> RTC").  I have built this config.  This patch is on top of the powerpc
> master tree.

I've already requested Paul to pull a defconfig update that includes
all changes besides the PCI_LEGACY disabling. Since it's not critical,
I'll do the same change in the for-2.6.26 branch but let the pull request
for 2.6.25 be as-is, if that's OK with you. This is of course with the
hopes that Paul will pull and push it before the .25 release.


Thanks,

-Olof
