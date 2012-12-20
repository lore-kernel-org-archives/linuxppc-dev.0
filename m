Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D1E1A2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2012 04:53:58 +1100 (EST)
Date: Thu, 20 Dec 2012 11:53:41 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: Adding 'of_platform' bus support to the platform driver
To: <R.Patil@mei-india.com>
References: <OFC91E62B9.4D486BD1-ON65257ADA.002E22B1-65257ADA.002E22B7@LocalDomain>
In-Reply-To: <OFC91E62B9.4D486BD1-ON65257ADA.002E22B1-65257ADA.002E22B7@LocalDomain>
 (from R.Patil@mei-india.com on Thu Dec 20 02:23:55 2012)
Message-ID: <1356026021.21086.4@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/20/2012 02:23:55 AM, R.Patil@mei-india.com wrote:
> Hello,
>=20
> We are working on one of the platform drivers for our board (based on =20
> MPC8313ERDB). Previously, this driver was supporting platform bus but =20
> now we want to change it to support 'of_platform' bus. While =20
> supporting platform bus, the platform device structure is initialised =20
> in board setup file, and platform device is registered using =20
> 'platform_device_register_simple' call.
>=20
> Now if we want to support 'of_platform' bus, the information related =20
> to the the device will be extracted from device tree in the platform =20
> driver itself and we would not be required to call =20
> 'platform_device_register_simple' to register the platform device. Is =20
> this understanding correct?

What kernel version are you using?  The of_platform bus doesn't exist =20
anymore.  The current way is to use a normal platform driver, and =20
supply an "of_match_table" in the driver struct.

-Scott=
