Return-Path: <jkosina@suse.cz>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C432CB7B6F
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Sep 2009 20:25:17 +1000 (EST)
Date: Fri, 18 Sep 2009 12:25:12 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: Peter Huewe <PeterHuewe@gmx.de>
Subject: Re: [PATCH] char/hvc: adding __init macro to char/hvc_vio.c
In-Reply-To: <200909170238.40051.PeterHuewe@gmx.de>
Message-ID: <alpine.LNX.2.00.0909181224570.17028@wotan.suse.de>
References: <200908202314.07443.PeterHuewe@gmx.de>
	<200909170238.40051.PeterHuewe@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Mike Frysinger <vapier@gentoo.org>,
	Nicolas Palix <npalix@diku.dk>, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 17 Sep 2009, Peter Huewe wrote:

> > Please have a look at the small patch and either pull it through
> > your tree, or please ack' it so Jiri can pull it through the trivial tree.
> >
> > linux version 2.6.31-rc6 - linus git tree, Do 20. Aug 22:26:06 CEST 2009
> >
> > Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> 
> Hi Jiri,
> this one got merged by Benjamin, so you can drop it from your queue :)
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=948c28fe3001f2c9d852dff2a0b2c69fe7cec91b

Dropped, thanks for letting me know.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
