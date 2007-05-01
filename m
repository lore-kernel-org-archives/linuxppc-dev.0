Return-Path: <dsnider@rgbnetworks.com>
Received: from magcamg01.planetmagpie.hosting (smtp3.planetmagpie.com
	[208.156.112.243]) by ozlabs.org (Postfix) with ESMTP id 5F377DDF4E
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 11:03:49 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Recommended xilinx TEMAC driver code?
Date: Mon, 30 Apr 2007 17:53:17 -0700
Message-ID: <A9D317FEBECCF742A1C04733D0A3FB6FC85E92@exch1.rgbnetworks.com>
In-Reply-To: <mailman.1196.1177787992.26657.linuxppc-embedded@ozlabs.org>
From: "Duane Snider" <dsnider@rgbnetworks.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


What is the recommended TEMAC driver start with?

So far I see the following options:
  - Grant Likely's Virtex tree with the drivers/net/xilinx_temac
  - David H Lynch's Pico portation with drivers/net/xilinx_temac and
drivers/net/temac.c


 Duane Snider
