Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A1071DDF38
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 05:02:49 +1000 (EST)
Message-ID: <46DEFD08.8060402@s5r6.in-berlin.de>
Date: Wed, 05 Sep 2007 21:01:28 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: debian-powerpc@lists.debian.org
Subject: firewire in prebuilt kernel packages (was Re: Sleep problems with
	kernels >= 2.6.21 on powerpc)
References: <6540c930708251937o2a9a23efv72a0f2b8947067bd@mail.gmail.com>	<6bffcb0e0708261621q25316becqce7b3ae2176f45a8@mail.gmail.com>	<20070827065246.GA21220@ime.usp.br>	<46D279E8.10001@edge.ping.de>	<46D72BC6.3020809@edge.ping.de>
	<20070905100754.57ab4e3e.akpm@linux-foundation.org>
	<46DEEBBE.4070201@s5r6.in-berlin.de>
In-Reply-To: <46DEEBBE.4070201@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Kristian_H=F8gsber?=, michal.k.k.piotrowski@gmail.com,
	rbrito@gmail.com, =?ISO-8859-1?Q?g?= <krh@redhat.com>,
	linux-kernel@vger.kernel.org, rjw@sisk.pl, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-pm@lists.linux-foundation.org, Tim Teulings <rael@edge.ping.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> On 30 Aug 2007 22:42:46 +0200 "Tim Teulings" <rael@edge.ping.de> wrote:
>>> The kernel is:
>>>> Linux kismet 2.6.22-1-powerpc #1 Sun Jul 29 13:58:06 CEST 2007 ppc GNU/Linux
>>> The relveant debian package:
>>>> linux-image-2.6.22-1-powerpc_2.6.22-3_powerpc.deb
>>> I'm running a mixture of debian testing/unstable.

At the moment, distributors should not provide the experimental
firewire-* drivers as the only or primary FireWire drivers, unless they
know exactly what the gotchas are.  As a hint, CONFIG_FIREWIRE currently
depends on EXPERIMENTAL, CONFIG_IEEE1394 does not.  Some basic
information can be found at http://wiki.linux1394.org/JujuMigration.
-- 
Stefan Richter
-=====-=-=== =--= --=-=
http://arcgraph.de/sr/
