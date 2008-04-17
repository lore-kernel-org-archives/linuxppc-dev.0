Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 57798DE62B
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 00:10:50 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m3HEAjx2013807
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 07:10:45 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m3HEAi0w019633
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 09:10:45 -0500 (CDT)
Date: Thu, 17 Apr 2008 09:10:44 -0500
From: Scott Wood <scottwood@freescale.com>
To: Li Yang <LeoLi@freescale.com>
Subject: Re: [PATCH v2][POWERPC] qe_lib and ucc_geth: switch to the cpm_muram
	implementation
Message-ID: <20080417141043.GA21793@ld0162-tx32.am.freescale.net>
References: <20080416182214.GA20056@polina.dev.rtsoft.ru>
	<989B956029373F45A0B8AF02970818900200750D@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <989B956029373F45A0B8AF02970818900200750D@zch01exm26.fsl.freescale.net>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Jeff Garzik <jgarzik@pobox.com>, Tabi Timur <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 16, 2008 at 08:38:19PM -0700, Li Yang wrote:
> It is a good thing to unify the CPM dpram operation and QE muram
> operation.  But I'm having concerns about the naming as CPM is an
> obsolete block.  Can we change to use the new name QE instead?

And then change it again when marketing decides that CPM4 will be called
something other than QE2? :-P

-Scott
