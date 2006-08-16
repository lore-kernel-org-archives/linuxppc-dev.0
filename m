Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx023.isp.belgacom.be (outmx023.isp.belgacom.be
	[195.238.4.204])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 67F3B67B52
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Aug 2006 23:07:04 +1000 (EST)
Received: from outmx023.isp.belgacom.be (localhost [127.0.0.1])
	by outmx023.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k7GD6qX8030328
	for <linuxppc-embedded@ozlabs.org>; Wed, 16 Aug 2006 15:06:53 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Did someone have a working SPI Driver for Linux 2.6
Date: Wed, 16 Aug 2006 15:09:35 +0200
References: <20060816125228.98000@gmx.net>
In-Reply-To: <20060816125228.98000@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608161509.35216.laurent.pinchart@tbox.biz>
Cc: Keinen Namen <GSM909@gmx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Did someone have a working SPI Driver for Linux 2.6 and the MPC82xx from
> Freescale?

I'm working on such a driver. I will try to send a patch in a few days. The 
driver is being tested on an MMC device, so basic functionalities should be 
there, but things are far from being finished.

Laurent Pinchart
