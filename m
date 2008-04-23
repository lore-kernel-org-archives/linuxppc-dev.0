Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2AB30DE463
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 02:01:40 +1000 (EST)
In-Reply-To: <1208905031.6947.0.camel@concordia>
References: <480E1939.6000701@matrix-vision.de>
	<20080422172306.GA17992@ld0162-tx32.am.freescale.net>
	<1208905031.6947.0.camel@concordia>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <49d9febd1f7b8022b6c418b592af2e33@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Question on MPC83xx interrupts
Date: Wed, 23 Apr 2008 18:00:26 +0200
To: michael@ellerman.id.au
Cc: Scott Wood <scottwood@freescale.com>,
	linux-ppc list <linuxppc-dev@ozlabs.org>,
	Andre Schwarz <andre.schwarz@matrix-vision.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> You can see the mapping between virq and hwirq numbers by turning on
> CONFIG_VIRQ_DEBUG and looking in /sys/kernel/debug/powerpc/virq_mapping
> (after mounting debugfs).

Ooh, nice!  Are there plans to move this into some "real" sysfs
nodes?


Segher
