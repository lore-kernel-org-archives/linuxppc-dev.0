Return-Path: <shemminger@osdl.org>
Received: from smtp.osdl.org (fire.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 95236679E2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 May 2005 04:32:25 +1000 (EST)
Date: Thu, 26 May 2005 11:32:18 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Andy Fleming <afleming@freescale.com>
Message-ID: <20050526113218.23e44164@dxpl.pdx.osdl.net>
In-Reply-To: <1107b64b01fb8e9a6c84359bb56881a6@freescale.com>
References: <1107b64b01fb8e9a6c84359bb56881a6@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Netdev <netdev@oss.sgi.com>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC: PHY Abstraction Layer II
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I finally got around to looking at this for the new skge driver.
The Marvell phy code has several issues:
	* hard coded hex values rather than constants
	* doesn't handle restricted autonegotiation
	* it doesn't really help the driver that much there are too
	  many other warts in the hardware.
