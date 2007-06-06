Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 60C0EDDE0C
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 00:36:36 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] [POWERPC] Some extra via-pmu exports
Date: Wed, 6 Jun 2007 16:35:27 +0200
References: <20070521150531.e498340a.sfr@canb.auug.org.au>
	<200706061605.48983.arnd@arndb.de>
	<1181139781.3666.3.camel@johannes.berg>
In-Reply-To: <1181139781.3666.3.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200706061635.27721.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 06 June 2007, Johannes Berg wrote:
> Actually, I think that with the latest patch I sent that disallows you
> to build APM-emulation for 64-bit (which doesn't make sense) this
> shouldn't be a problem any more. Are tehre still some that need
> exporting?

Sorry, I must have missed your patch.
I can confirm that in 2.6.22-rc4 Stephen's patch is no longer needed.

	Arnd <><
