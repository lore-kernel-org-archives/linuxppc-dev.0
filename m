Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 967A6DE451
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 06:18:27 +1100 (EST)
Date: Tue, 25 Mar 2008 12:18:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH 2/2 v2] Add DIU platform code for MPC8610HPCD
Message-Id: <20080325121804.a273944e.akpm@linux-foundation.org>
In-Reply-To: <20080325124322.GH12798@shadowen.org>
References: <12059526271941-git-send-email-yorksun@freescale.com>
	<12059526274026-git-send-email-yorksun@freescale.com>
	<12059526271964-git-send-email-yorksun@freescale.com>
	<20080320153304.cdc1817d.akpm@linux-foundation.org>
	<20080325124322.GH12798@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net,
	yorksun@freescale.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 25 Mar 2008 12:43:22 +0000
Andy Whitcroft <apw@shadowen.org> wrote:

> > > ...
> > >
> > > +unsigned int mpc8610hpcd_get_pixel_format
> > > +	(unsigned int bits_per_pixel, int monitor_port)
> 
> This seems like it might be detectable, does this seem like something we
> should try an report?

I guess so.  It's quite unusual.
