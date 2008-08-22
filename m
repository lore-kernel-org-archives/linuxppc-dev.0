Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 74569DE737
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Aug 2008 03:11:42 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m7MHBaoN001744
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 10:11:37 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m7MHBZ7R002688
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 12:11:35 -0500 (CDT)
Date: Fri, 22 Aug 2008 12:11:35 -0500
From: Scott Wood <scottwood@freescale.com>
To: Martyn Welch <martyn.welch@gefanuc.com>
Subject: Re: [PATCH v2 1/2] powerpc: Board support for GE Fanuc SBC610
Message-ID: <20080822171135.GA15623@ld0162-tx32.am.freescale.net>
References: <20080822104615.11984.93838.stgit@ubuntu8041.localdomain>
	<20080822104620.11984.30369.stgit@ubuntu8041.localdomain>
	<72120CFB-62D9-44B0-AD4F-26332C90F3C9@kernel.crashing.org>
	<20080822121152.70f01597.martyn.welch@gefanuc.com>
	<20080822122601.162dddd4.martyn.welch@gefanuc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080822122601.162dddd4.martyn.welch@gefanuc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 22, 2008 at 12:26:01PM +0100, Martyn Welch wrote:
> > > drop device_type.
> > > 
> > 
> > Ah - _all_ device_type!
> > 
> 
> Um, not all - just the ones where the name of the block matches the
> device type(?)

All except "cpu" and "memory".

-Scott
