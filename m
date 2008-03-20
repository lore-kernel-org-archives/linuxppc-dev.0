Return-Path: <John.Linn@xilinx.com>
Received: from outbound8-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 6E594DDFDA
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 01:42:31 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: [PATCH 0/3] [POWERPC] [RFC] of_serial and boot patches introduction
Date: Thu, 20 Mar 2008 08:42:24 -0600
In-Reply-To: <12060236493879-git-send-email-john.linn@xilinx.com>
References: <12060236493879-git-send-email-john.linn@xilinx.com>
From: "John Linn" <John.Linn@xilinx.com>
To: <linuxppc-dev@ozlabs.org>, <grant.likely@secretlab.ca>,
	<jwboyer@linux.vnet.ibm.com>
Message-Id: <20080320144227.96A311A88055@mail53-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am sending a series of patches that fix the OF serial driver and add
support to it and the boot for the Xilinx UART 16550.

I think we have tried to satisfy previous concerns about UARTs which are
non-standard as the Xilinx 16550 is (register spacing and offset).

We would like to have these pulled into 2.6.26.

Thanks,
John
