Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE22167BCE
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Dec 2006 20:05:46 +1100 (EST)
Subject: Re: Is in_le32 and out_le32 atomic?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <457D12B0.3010701@grandegger.com>
References: <4579C586.5040809@grandegger.com>
	<200612082115.38812.arnd@arndb.de>
	<1165819718.7260.40.camel@localhost.localdomain>
	<457D12B0.3010701@grandegger.com>
Content-Type: text/plain
Date: Mon, 11 Dec 2006 20:05:32 +1100
Message-Id: <1165827933.7260.44.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> Then the spinlock makes sense avoiding the interruption of the 
> subsequent read write accesses.
> 
> Sorry for the noise.

Ok, yes, it does make sense in that context then.

Ben.
