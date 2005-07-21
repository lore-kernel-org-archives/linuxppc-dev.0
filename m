Return-Path: <kylej@aiinet.com>
Received: from aiexchange.ai.aiinet.com (ai181-184.aiinet.com
	[205.245.181.184]) by ozlabs.org (Postfix) with ESMTP id 5E93E67CBB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Jul 2005 21:51:42 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 21 Jul 2005 07:39:36 -0400
Message-ID: <C0170D0AF1277849A4B4518034F855DD0F91AA@aiexchange.ai.aiinet.com>
From: "Jordan, Kyle" <kylej@aiinet.com>
To: "???" <daihonggang@utpower.com.cn>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: help
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>=20
>=20
> can you give me the driver of isp1362, thanks a lot.
>=20


I have a driver for the isp1362 in host controller mode for a 2.4.x
kernel.  However, isochronous endpoints are not working with it.  I
think there is another driver for the 2.6.x kernel out there.  Which
kernel are you using?

- Kyle
