Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id B8C6A67C06
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 20:55:01 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k7NAsxKa023331
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 03:54:59 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k7NAsvWk005489
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 05:54:58 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: BogoMIPS no longer supported on PowerPC?
Date: Wed, 23 Aug 2006 18:55:26 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0FC20C@zch01exm20.fsl.freescale.net>
In-Reply-To: <1156329453.3914.13.camel@ux156>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Johannes Berg" <johannes@sipsolutions.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, I rephrase my question as is it no longer needed?  Sometimes people
may use this value as a rough estimation of CPU performance.  There are
people even maintained a list of bogoMIPS of most CPUs.  Maybe it is
still needed for some legacy reasons.  I'm not very sure.  :)   At leave
we need to inform people who do look at this magic number and find it
amazingly low.

Best Regards,
Leo
> -----Original Message-----
> From: Johannes Berg [mailto:johannes@sipsolutions.net]
> Sent: Wednesday, August 23, 2006 6:38 PM
> To: Li Yang-r58472
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: BogoMIPS no longer supported on PowerPC?
>=20
> On Wed, 2006-08-23 at 18:25 +0800, Li Yang-r58472 wrote:
> > I noticed a recent modification to __delay has changed from using
empty
> > loops to reading timebase.  Thus, breaks the calculation of
bogomips,
> > and makes it terribly low.  Is the bogomips no longer being
supported on
> > powerpc arch?
>=20
> What's there to be 'supported'? The only purpose of bogomips is
> calibrating the delay loop, and that has changed now by using
timebase,
> hence bogomips no longer have a purpose. There was even a patch to
> remove it from /proc/cpuinfo but I'm not sure whether that got applied
> or not.
>=20
> johannes
