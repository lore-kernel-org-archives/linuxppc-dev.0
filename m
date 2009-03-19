Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 92D2FDDEEA
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 08:14:23 +1100 (EST)
Subject: Re: IDE cable detection on Apple PowerBook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090319134113.GA31953@oksana.dev.rtsoft.ru>
References: <20090318140638.e6b61eaa.posco.grubb@gmail.com>
	<1237363097.25062.345.camel@pasglop>
	<20090318224726.5cf83e23.posco.grubb@gmail.com>
	<1237442846.25062.466.camel@pasglop>
	<1237442917.25062.467.camel@pasglop>
	<20090319223001.c2674366.posco.grubb@gmail.com>
	<20090319134113.GA31953@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Fri, 20 Mar 2009 08:14:14 +1100
Message-Id: <1237497254.25062.473.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, TOMARI Hisanobu <posco.grubb@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-03-19 at 16:41 +0300, Anton Vorontsov wrote:
> 
> The other option is to enable BLK_DEV_IDE_PMAC_SHORTCABLE by default,
> but I'm not sure if it's safe thing to do (most probably not).

It should be allright for powerbooks. If the firmware says 80 pin cable,
then it probably is, and in fact, It used to work, I think the test in
the IDE code is new there, and MacOS X solely relies on the firmware
data.

Ben.
