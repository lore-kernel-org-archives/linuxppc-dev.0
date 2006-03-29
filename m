Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1EE7A679EB
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 15:01:43 +1100 (EST)
Subject: Re: snd-aoa: new apple sound driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1143547826.13615.24.camel@localhost>
References: <1143547826.13615.24.camel@localhost>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 15:01:18 +1100
Message-Id: <1143604878.3585.5.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, debian-powerpc <debian-powerpc@lists.debian.org>,
	Alastair Poole <netstar@gatheringofgray.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

BTW.. with the current stuff, if I install the modules and then do

modprobe i2sbus

I get a registration error in dmesg. If I then try to rmmod it, the
machine blows up. Haven't had time to track that down at this point.
Appart from that, it works and I can play morse with myh SPID output :)

Oh, and jackd seems to be unhappy even if I tell it to ignore the
capture channels, it's probably a problem with setting the sample
formats, I haven't looked in detail (yet).

Ben.
