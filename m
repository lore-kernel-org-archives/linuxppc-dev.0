Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 28530B70D0
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Feb 2011 06:42:21 +1100 (EST)
Subject: Re: rtc on PowerMac7,3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kevin diggs <diggskevin38@gmail.com>
In-Reply-To: <AANLkTinz=CrCTEeAPQjE8B=yjQx+WLs_FKj2u+0-JeAS@mail.gmail.com>
References: <AANLkTinz=CrCTEeAPQjE8B=yjQx+WLs_FKj2u+0-JeAS@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 24 Feb 2011 06:42:10 +1100
Message-ID: <1298490130.8833.212.camel@pasglop>
Mime-Version: 1.0
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-02-23 at 13:39 -0600, kevin diggs wrote:
> Hi,
> 
> Sorry for the noise.
> 
> How do I access the rtc on a PowerMac7,3 (dual 2.5 GHz 970FX) using
> 2.6.36? rtc-generic does not seem to work. It will work on my 8600. I
> do see this:
> 
> [   15.014542] rtc-generic rtc-generic: rtc core: registered rtc-generic as rtc0

rtc-generic should work... 

Cheers,
Ben.

> Is it the hwclock binary:
> 
> hwclock from util-linux-2.13-pre7
> 
> I think I could get this to work in 2.6.28 using rtc-ppc.
> 
> Thanks!
> 
> kevin
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
