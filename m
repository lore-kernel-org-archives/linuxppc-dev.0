Return-Path: <mchan@broadcom.com>
Received: from mms2.broadcom.com (mms2.broadcom.com [216.31.210.18])
	by ozlabs.org (Postfix) with ESMTP id A1F46DDFBC
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 01:16:48 +1000 (EST)
MIME-Version: 1.0
Subject: Re: dead network on JS21 with tg3 driver after flowcontrol
 changes
Date: Thu, 15 May 2008 08:10:16 -0700
Message-ID: <1551EAE59135BE47B544934E30FC4FC002AABCEE@nt-irva-0751.brcm.ad.broadcom.com>
In-Reply-To: <20080515121340.GA23033@aepfle.de>
From: "Michael Chan" <mchan@broadcom.com>
To: "Olaf Hering" <olaf@aepfle.de>, "Matthew Carlson" <mcarlson@broadcom.com>
Content-Type: text/plain;
 charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering wrote:

> Any ideas how to fix this?
> What info do you need from the system?

Are you using eth0 or eth1?  The dmesg below shows that
link came up on eth1 and IP address from DHCP was received.


> Sending DHCP requests .<6>tg3: eth1: Link is up at 1000 Mbps,=20
> full duplex.
> tg3: eth1: Flow control is off for TX and off for RX.
> ., OK
> IP-Config: Got DHCP answer from 10.10.4.97, my address is 10.10.1.110
> IP-Config: Complete:

If you're using eth0 and link did not come up, please provide
mii-tool -vvv eth0.

Thanks.
