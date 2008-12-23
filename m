Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6A9F5DDE9E
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Dec 2008 07:23:10 +1100 (EST)
Subject: Re: schizophrenic G5 ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Krafft <parabelboi@bopserverein.de>
In-Reply-To: <20081223172245.792a9e2b@bopserverein.de>
References: <494EDB3F.4090604@hypersurf.com>
	<20081223172245.792a9e2b@bopserverein.de>
Content-Type: text/plain
Date: Wed, 24 Dec 2008 07:23:02 +1100
Message-Id: <1230063782.7292.4.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I have a very similar problem on my mac at work.
> I don't know atm how to look up the critical temperature that is
> fused. My mac reported only 55 degrees for the one cpu.
> The critical temperature can be read from the device-tree if i remember
> it correctly.
> I heard that there exists a bootable CD which contains a tool to refuse
> the CPU. Dont know where to download it, so my pragmatic solution was to
> relocate the machine to a room with air conditioning ;-)
> And I also run the ONE cpu at lowest frequency.

The calibration info is in an i2c EEPROM iirc, though we read it's
content via the device-tree.

Cheers,
Ben.
