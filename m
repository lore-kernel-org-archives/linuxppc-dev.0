Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C5CC7DDD06
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 04:18:56 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8DIIrnF018925
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 14:18:53 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8DIIr8K503044
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 12:18:53 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8DIIrUa019620
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 12:18:53 -0600
Date: Thu, 13 Sep 2007 13:18:51 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] usb: add support for device tree aware EHCI driver
Message-ID: <20070913131851.56fcc377@weaponx.rchland.ibm.com>
In-Reply-To: <20070913175702.GA24682@ru.mvista.com>
References: <20070913175702.GA24682@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 13 Sep 2007 21:57:02 +0400
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> Some PowerPC systems have a built-in EHCI controller.
> This is a device tree aware version of the EHCI controller driver.
> Currently it's been tested on the PowerPC 440EPx Sequoia board.
> Other platforms can be added later.
> The code is based on the ehci-ppc-soc driver by Stefan Roese <sr@denx.de>.
> The of_platform support is based on ohci-ppc-of driver
> by Sylvain Munaut <tnt@246tNt.com>.

Where's the DTS binding for this?  It doesn't exist in the current
sequoia.dts.

josh
