Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 194AEDE250
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Aug 2008 00:19:46 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m77EJePC022593
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Aug 2008 07:19:41 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m77EJd80017740
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Aug 2008 09:19:40 -0500 (CDT)
Date: Thu, 7 Aug 2008 09:19:39 -0500
From: Scott Wood <scottwood@freescale.com>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 4/6] powerpc: add USB peripheral support to MPC8272ADS
Message-ID: <20080807141939.GA20963@ld0162-tx32.am.freescale.net>
References: <1218006285-27138-1-git-send-email-leoli@freescale.com>
	<1218006285-27138-2-git-send-email-leoli@freescale.com>
	<1218006285-27138-3-git-send-email-leoli@freescale.com>
	<1218006285-27138-4-git-send-email-leoli@freescale.com>
	<20080806171949.GA3138@ld0162-tx32.am.freescale.net>
	<1218081014.29628.9.camel@Gundam>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1218081014.29628.9.camel@Gundam>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 07, 2008 at 11:50:14AM +0800, Li Yang wrote:
> udc is a common name for USB device mode drivers to work with Linux
> gadget.  We will have two separate drivers for USB host and device.
> Probably we can have two compatibles "fsl,qe_udc" and "fsl,qe-usb-host"

1. If you have separate compatibles, what do you need the "mode" property
for?
2. mpc8272 is not QE.
3. fsl,cpm2-usb-slave would be much more readable than fsl,qe_udc.

-Scott
