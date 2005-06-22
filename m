Return-Path: <kylej@aiinet.com>
Received: from aiexchange.ai.aiinet.com (ai181-151.aiinet.com
	[205.245.181.151]) by ozlabs.org (Postfix) with ESMTP id B75DC67AA0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Jun 2005 21:53:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 22 Jun 2005 07:40:44 -0400
Message-ID: <C0170D0AF1277849A4B4518034F855DD0F918D@aiexchange.ai.aiinet.com>
From: "Jordan, Kyle" <kylej@aiinet.com>
To: <j.lu@tiesse.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: isp1362 usb driver 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jianliang Lu,

> the device is a adsl modem, it works correctly in other linux=20
> systems with kernel 2.4.2x. The problem is that the isp1362 driver=20
> seems that supports only isochronous endpoints. We are=20
> implementing the code to support also control/bulk/interrupt=20
> endpoints.

	I had similar issues with control/bulk/interrupt endpoints with
the ISP1362 host controller driver from DENX.  I went ahead and added
better support for control/bulk/interrupt endpoints.  I could send you a
copy of the source if you like.  The driver is being used on an MPC880,
with the 2.4.21 kernel.  Also, what ADSL modem are using?  We are
looking into a solution requiring an ADSL modem and the one you are
using may be a good solution for us also.

- Kyle
