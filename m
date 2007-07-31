Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AA1BCDDDF9
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 06:14:31 +1000 (EST)
Message-ID: <46AF9820.7050608@am.sony.com>
Date: Tue, 31 Jul 2007 13:14:24 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: =?UTF-8?B?77+9?= <rene@exactcode.de>
Subject: Re: Using video memory on PS3 e.g. as SWAP?
References: <200707291904.55700.rene@exactcode.de>
In-Reply-To: <200707291904.55700.rene@exactcode.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=EF=BF=BD wrote:
> Hi all,
>=20
> looking at the PS3 as one of the few PowerPC workstation options the RA=
M
> is obviously quite limitted with just 256MB.=20


Can I recommend in the future you send this kind of PS3 specific inquiry =
to
the cbe-oss-dev mailing list?

  cbe-oss-dev@ozlabs.org
  https://ozlabs.org/mailman/listinfo/cbe-oss-dev


> I wonder if the 256MB of
> video memory can be mapped or at least be used as super-fast SWAP?


As Marc mentioned, some work was done using unsupported functionality of
the current hypervisor.  There is no assurance it will continue to work
with future system software updates.


> Or are there news regarding accessing the video chip from Linux beside
> the unaccelerated frame-buffer?


We plan to improve Linux graphics support, but we have not announced any
specifics.  The changes may make the above mentioned driver no longer wor=
k.

-Geoff
