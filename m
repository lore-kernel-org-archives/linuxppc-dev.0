Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 573E9DDEA3
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 03:36:29 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [CURIOUSITY] When will we stop caring about arch/ppc?
Date: Tue, 26 Jun 2007 19:03:41 +0200
References: <20070625182304.GC31840@mag.az.mvista.com>
	<1182864764.19501.7.camel@weaponx.rchland.ibm.com>
	<1ce7f225511ea3d67a63b8a4ac683e0c@kernel.crashing.org>
In-Reply-To: <1ce7f225511ea3d67a63b8a4ac683e0c@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706261903.41801.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 26 June 2007, Segher Boessenkool wrote:
> Well the arch/ppc tree is basically frozen already, all Freescale
> stuff got moved over already as far as I can see, and 4xx has
> started moving.

8xx has been moved over, but last time I tried, it was not possible
to actually compile that code. Note sure if the arch/ppc version of
it is in a much better shape though.

82xx seems to be in a similar state to 4xx, with a single platform
moved over, but most of the code still being arch/ppc only.

	Arnd <><
