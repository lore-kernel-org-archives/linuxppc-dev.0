Subject: Re: [PATCH][RFC] Second version of MPC10x OCP
From: Adrian Cox <adrian@humboldt.co.uk>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-embedded@lists.linuxppc.org, mgreer@mvista.com
In-Reply-To: <282B6E73-C58F-11D8-9384-000393DBC2E8@freescale.com>
References: <1087746455.1547.23.camel@newt>
	 <282B6E73-C58F-11D8-9384-000393DBC2E8@freescale.com>
Content-Type: text/plain
Message-Id: <1088078926.1372.13.camel@localhost>
Mime-Version: 1.0
Date: Thu, 24 Jun 2004 17:36:52 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-06-24 at 04:32, Kumar Gala wrote:
> I'm confused are we adding the OCP struct for every 10x device?  Did we
> get closure on the question if 105, 106 & 8240 would also work?

According to the chip manuals:
107, 8240, and 8245 have the internal peripherals and should work.
105 and 106 don't have internal peripherals.

mpc10x_common.c supports 106, 107, 8240, and 8245, but does not support
105.

The code only adds the OCP devices if the device is not 106.

My patch is slightly broken where I edited out a local board variant by
hand. I'll produce a cleaned up patch based on my Sandpoint tree once
I've tested it together with the 85xx I2C driver.

- Adrian Cox
Humboldt Solutions Ltd.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
