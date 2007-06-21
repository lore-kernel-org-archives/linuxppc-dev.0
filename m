Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C4EA3DDEE7
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 08:18:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [patch 18/33] PS3: Frame buffer system-bus rework
Date: Thu, 21 Jun 2007 15:18:25 -0700
Message-ID: <591B6A09961C354991CD653B274DC8C203E0521B@ussdixms03.am.sony.com>
References: <20070615204749.629571012@am.sony.com><46730D32.8060803@am.sony.com>
	<18039.31768.282185.497245@cargo.ozlabs.ibm.com>
From: "Levand, Geoffrey" <Geoffrey.Levand@am.sony.com>
To: "Paul Mackerras" <paulus@samba.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----Original Message-----
From: Paul Mackerras [mailto:paulus@samba.org]
Sent: Mon 6/18/2007 11:47 PM
To: Levand, Geoffrey
Cc: linuxppc-dev@ozlabs.org; linux-fbdev-devel@lists.sourceforge.net; =
Geert Uytterhoeven
Subject: Re: [patch 18/33] PS3: Frame buffer system-bus rework
=20
Geoff Levand writes:

> From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
>=20
> Convert the ps3fb device from a platform device to a PS3 system bus =
device.
> Fix the remove and shutdown methods to support kexec and to make ps3fb =
a
> loadable module.

Are you going to submit this to the fb maintainer (Antonio Daplas?) or
do you want me to take it because of dependencies on other patches in
your series?


Hi Paul,

Sorry for the delay, and this formatting.  I am away on holiday,
with just a crappy Web browser interface...

I was hoping you could take it, as it fits in with the series, and
touches my platform code.  Thanks.

-Geoff
