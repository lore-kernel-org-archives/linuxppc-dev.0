Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 29B38DDEC8
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 00:06:04 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [POWERPC] Some extra via-pmu exports
Date: Wed, 6 Jun 2007 16:05:48 +0200
References: <20070521150531.e498340a.sfr@canb.auug.org.au>
In-Reply-To: <20070521150531.e498340a.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706061605.48983.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 21 May 2007, Stephen Rothwell wrote:
> pmu_battery_count, pmu_batteries, pmu_power_flags were only exported
> for 32 bit builds but are now needed for 64 bit as well.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

I haven't seen this one show up in 2.6.22-rc or powerpc.git yet,
but I think we should have it in there to avoid build breakage.

I stumbled over the same bug and wanted to submit a fix when
I saw it was posted already.

	Arnd <><
