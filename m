Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AFD7C68110
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Aug 2005 15:36:07 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20050825051528.GB19792@suse.de>
References: <20050824115452.GA29148@suse.de>
	<1124922771.5159.134.camel@gaston> <20050825045108.GA19792@suse.de>
	<1124946481.7906.8.camel@gaston>  <20050825051528.GB19792@suse.de>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 15:34:31 +1000
Message-Id: <1124948071.7907.10.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: AC Power handling broken for desktops
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-08-25 at 07:15 +0200, Olaf Hering wrote:
>  On Thu, Aug 25, Benjamin Herrenschmidt wrote:
> 
> > Not sure :) I don't fully know how to decode those power things in the
> > device-tree... There are bits in darwin tho.
> 
> Maybe just check for !PowerBook and force PMU_PWR_AC_PRESENT in this case.

Yah, you can check that with pmac_feature, there is a "mobile" flag.

Ben
