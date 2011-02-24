Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4225CB70DC
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Feb 2011 11:10:01 +1100 (EST)
Subject: Re: rtc on PowerMac7,3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kevin diggs <diggskevin38@gmail.com>
In-Reply-To: <AANLkTinB+CLhJsiu3SBygC7TW+vnOH3e7==h_7nEGWts@mail.gmail.com>
References: <AANLkTinz=CrCTEeAPQjE8B=yjQx+WLs_FKj2u+0-JeAS@mail.gmail.com>
	<1298490130.8833.212.camel@pasglop>
	<AANLkTinB+CLhJsiu3SBygC7TW+vnOH3e7==h_7nEGWts@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 24 Feb 2011 11:09:52 +1100
Message-ID: <1298506192.8833.222.camel@pasglop>
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

On Wed, 2011-02-23 at 17:24 -0600, kevin diggs wrote:
> It probably does on everyone else's 7,3. The 8600 probably infected
> it. ... I hear the two of them out there late at night. Mumbling to
> each other ... plotting ...

Not sure, I haven't looked at that RTC stuff for ages. Basically the
platform code provides generic RTC hooks (in that G5 it's going to be
via the via-pmu) and it should "just work". That code hasn't been
touched for eons.

Cheers,
Ben.
