Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0A214DE1CE
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 07:58:27 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m3GLwNqU010023
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 14:58:23 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m3GLwMVI016829
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 16:58:22 -0500 (CDT)
Date: Wed, 16 Apr 2008 16:58:21 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 6/8] [POWERPC] sysdev,qe_lib: implement FSL GTM support
Message-ID: <20080416215821.GA15566@ld0162-tx32.am.freescale.net>
References: <20080311172106.GA4766@localhost.localdomain>
	<20080311172429.GF7727@localhost.localdomain>
	<20080318174329.GB4099@loki.buserror.net>
	<20080318192152.GA26493@localhost.localdomain>
	<47E01E22.9000807@freescale.com>
	<20080318202717.GA1030@localhost.localdomain>
	<47E02A8C.2080705@freescale.com>
	<20080416183904.GA23512@polina.dev.rtsoft.ru>
	<20080416184442.GA12179@ld0162-tx32.am.freescale.net>
	<20080416210042.GA3579@zarina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080416210042.GA3579@zarina>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 17, 2008 at 01:00:42AM +0400, Anton Vorontsov wrote:
> On Wed, Apr 16, 2008 at 01:44:42PM -0500, Scott Wood wrote:
> > A maximal timeout of ~65 ms is a little low...  For use as a wakeup from
> > sleep mode, I'd like to be able to request timeouts as large as the
> > hardware allows.
> 
> That is about precision. You just need to implement gtm_reset_stimer()
> is you want precision with a seconds, this will run a timer at 1 Hz.

Enh.  I'm not crazy about having to call separately named functions,
rather than have the timer code set the reference clock to the highest
precision that has the needed range.

-Scott
