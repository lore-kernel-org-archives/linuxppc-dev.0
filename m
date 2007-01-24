Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9F258DE0AD
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 10:04:27 +1100 (EST)
Subject: Re: Xserve G5 doesn't reboot or restart properly with SMU compiled in
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Massimiliano Vegni <m.vegni@it-systems.it>
In-Reply-To: <45B7E2C4.4050303@it-systems.it>
References: <45B6BC79.5060904@it-systems.it>
	<1169620786.18754.72.camel@localhost.localdomain>
	<45B7E2C4.4050303@it-systems.it>
Content-Type: text/plain
Date: Thu, 25 Jan 2007 10:04:15 +1100
Message-Id: <1169679856.24996.9.camel@localhost.localdomain>
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

Also have you tried without CONFIG_PREEMPT ? Might be a bug there...

Ben.
