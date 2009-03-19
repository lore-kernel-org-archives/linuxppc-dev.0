Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1027DDDDA1
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 04:05:35 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n2JH5VYm023551
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 10:05:31 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n2JH5U8c020443
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 12:05:31 -0500 (CDT)
Date: Thu, 19 Mar 2009 12:05:30 -0500
From: Scott Wood <scottwood@freescale.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2 4/5] powerpc: NAND: FSL UPM: document new bindings
Message-ID: <20090319170530.GA2744@ld0162-tx32.am.freescale.net>
References: <1237475768-11481-1-git-send-email-wg@grandegger.com>
	<1237475768-11481-2-git-send-email-wg@grandegger.com>
	<1237475768-11481-3-git-send-email-wg@grandegger.com>
	<1237475768-11481-4-git-send-email-wg@grandegger.com>
	<1237475768-11481-5-git-send-email-wg@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1237475768-11481-5-git-send-email-wg@grandegger.com>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 19, 2009 at 04:16:07PM +0100, Wolfgang Grandegger wrote:
> +Optional properties:
> +- fsl,upm-mar-offset : use the UPM machine address register to drive a
> +  		       custom chip select logic using the specified
> +		       offset.

Your example uses the name fsl,upm-mar-chip-offset instead.

> +- chip-offset : address offset between chips for multi-chip support.

How is this different from fsl,upm-mar-offset?

-Scott
