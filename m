Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by ozlabs.org (Postfix) with ESMTP id 1A47FDDE07
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jan 2008 12:43:24 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so2896930pyg.27
	for <linuxppc-dev@ozlabs.org>; Sat, 05 Jan 2008 17:43:23 -0800 (PST)
Date: Sat, 5 Jan 2008 19:43:17 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] ibm_newemac: Increase number of default rx-/tx-buffers
Message-ID: <20080105194317.444b49c4@vader.jdub.homelinux.org>
In-Reply-To: <1199570068.7291.65.camel@pasglop>
References: <1199526609-12290-1-git-send-email-sr@denx.de>
	<1199528388.7291.55.camel@pasglop> <200801051338.17957.sr@denx.de>
	<1199566386.7291.58.camel@pasglop>
	<20080105154805.118eb3d1@vader.jdub.homelinux.org>
	<1199570068.7291.65.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 06 Jan 2008 08:54:28 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Sat, 2008-01-05 at 15:48 -0600, Josh Boyer wrote:
> > No need for a defconfig update patch.  Paul or I usually do a general
> > defconfig update for most boards before the next kernel version.  This
> > will get picked up then.
> 
> Will it ? I think the defconfigs will stick to the old value.

Put another way, if Kconfig doesn't update it automagically, I'll be
sure to do it myself. :)

josh
