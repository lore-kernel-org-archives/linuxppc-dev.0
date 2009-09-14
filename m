Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 83871B7B61
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 03:33:37 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D1179DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 03:33:36 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8EHXXXp021356
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 10:33:34 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n8EHXXXl021537
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 12:33:33 -0500 (CDT)
Date: Mon, 14 Sep 2009 12:33:32 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v2 0/5] Suspend/resume support for some 83xx/85xx/86xx
	boards
Message-ID: <20090914173332.GB9074@b07421-ec1.am.freescale.net>
References: <20090830193625.GA14693@oksana.dev.rtsoft.ru>
	<20090914153349.GA31420@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090914153349.GA31420@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 14, 2009 at 07:33:49PM +0400, Anton Vorontsov wrote:
> On Sun, Aug 30, 2009 at 11:36:25PM +0400, Anton Vorontsov wrote:
> > On Fri, Aug 28, 2009 at 12:38:51AM -0500, Kumar Gala wrote:
> > > >This patch adds suspend/resume support for MPC8540-compatible and
> > > >MPC8569 CPUs.
> > [...] 
> > > I'd also like to get Scott's Ack on this and the device tree patches
> > > before accepting them.

ACK the device tree stuff.

-Scott
