Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 415F767B57
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 18:12:50 +1000 (EST)
Subject: Re: snd-aoa: g5 tas codec problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1152259414.15068.12.camel@localhost>
References: <1152258426.9862.44.camel@localhost.localdomain>
	<1152259414.15068.12.camel@localhost>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 18:12:41 +1000
Message-Id: <1152259962.9862.51.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I see you added DRC too, thanks :) I'll take a closer look after
> breakfast ;)

Hehe :) Oh I just added a routine to program it in hardware, not any
control to actually change it.

Ben.
