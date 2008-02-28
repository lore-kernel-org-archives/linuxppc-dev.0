Return-Path: <John.Linn@xilinx.com>
Received: from outbound9-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7825FDDEEF
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 03:07:21 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: FW: [PATCH] Xilinx: BSP: Updated ML405 to match hardware used for
	testing
Date: Thu, 28 Feb 2008 09:07:16 -0700
In-Reply-To: <20080228110153.00eb5e1d.sfr@canb.auug.org.au>
References: <20080227231521.4673DE3006A@mail124-dub.bigfish.com>
	<20080228110153.00eb5e1d.sfr@canb.auug.org.au>
From: "John Linn" <John.Linn@xilinx.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Message-Id: <20080228160718.4AA8E1298060@mail127-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I think I found my problem that mangled the messages.  I really meant to
send both messages to the embedded ppc list rather than this more
general list.

Thanks,
John

-----Original Message-----
From: Stephen Rothwell [mailto:sfr@canb.auug.org.au]=20
Sent: Wednesday, February 27, 2008 5:02 PM
To: John Linn
Cc: linuxppc-dev@ozlabs.org; git-dev
Subject: Re: FW: [PATCH] Xilinx: BSP: Updated ML405 to match hardware
used for testing

Hi John,

n Wed, 27 Feb 2008 16:15:18 -0700 "John Linn" <John.Linn@xilinx.com>
wrote:
>
> The default config file for the ML405 and the xparameters*.h file
> were updated to match the hardware used for testing. The platform
> data in virtex_devices.c was updated for the LL TEMAC driver
> which now uses the dcr_host field to determine if it should use
> DCR for the DMA.
>=20
> Signed-off-by: John Linn <john.linn>

This was badly wrapped as well.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
