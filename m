Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 098C7B7D8C
	for <linuxppc-dev@ozlabs.org>; Tue, 18 May 2010 05:54:56 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o4HJsrsJ009133
	for <linuxppc-dev@ozlabs.org>; Mon, 17 May 2010 12:54:53 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o4HK51Yr003558
	for <linuxppc-dev@ozlabs.org>; Mon, 17 May 2010 15:05:01 -0500 (CDT)
Date: Mon, 17 May 2010 14:54:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: Shawn Jin <shawnxjin@gmail.com>
Subject: Re: mpc870 support in the powerpc arch?
Message-ID: <20100517195451.GA19894@schlenkerla.am.freescale.net>
References: <AANLkTikk8-jiDZNtP8eucP90DLYRALwu749H-3v9LsHI@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikk8-jiDZNtP8eucP90DLYRALwu749H-3v9LsHI@mail.gmail.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 14, 2010 at 02:41:29PM -0700, Shawn Jin wrote:
> Hi,
> 
> Is mpc870 fully supported in the powerpc arch? I know it's an old
> processor but 8xx is still one of platforms in the powerpc arch. If
> it's not supported, how much effort will it be to resurrect mpc870 in
> the new arch considering we have substantial 8xx support?

It should work, with appropriate board support -- MPC875 and MPC885 have
been used with arch/powerpc, and MPC870 is very similar (albeit with fewer
devices).

-Scott
