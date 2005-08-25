Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1071A67F88
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Aug 2005 15:15:33 +1000 (EST)
Date: Thu, 25 Aug 2005 07:15:28 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050825051528.GB19792@suse.de>
References: <20050824115452.GA29148@suse.de> <1124922771.5159.134.camel@gaston>
	<20050825045108.GA19792@suse.de> <1124946481.7906.8.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1124946481.7906.8.camel@gaston>
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

 On Thu, Aug 25, Benjamin Herrenschmidt wrote:

> Not sure :) I don't fully know how to decode those power things in the
> device-tree... There are bits in darwin tho.

Maybe just check for !PowerBook and force PMU_PWR_AC_PRESENT in this case.
