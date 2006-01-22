Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3047E689FD
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jan 2006 14:43:12 +1100 (EST)
Subject: Re: 2.6.16-r1 sound
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Douglas Russell <puggy@gentoo.org>
In-Reply-To: <200601211833.06139.puggy@gentoo.org>
References: <200601211833.06139.puggy@gentoo.org>
Content-Type: text/plain
Date: Sun, 22 Jan 2006 14:43:03 +1100
Message-Id: <1137901384.24244.3.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-01-21 at 18:33 +0000, Douglas Russell wrote:
> ALSA sound seems to have stopped working under 2.6.16-rc1 on my powerbook 5,6. 
> The kernel just doesn't seem to find a sound device. It works fine when I go 
> back to 2.6.15-rc5 which I was on before.

Known problem, will be fixed before 2.6.16 is final.

Ben.
