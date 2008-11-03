Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 661CADDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 07:19:40 +1100 (EST)
Subject: Re: Connecting to "PCI command write" interrupt on 4xx platforms
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
In-Reply-To: <200811031445.00963.matthias.fuchs@esd-electronics.com>
References: <200810301158.46686.matthias.fuchs@esd-electronics.com>
	<200811031010.33250.matthias.fuchs@esd-electronics.com>
	<1225709863.8004.252.camel@pasglop>
	<200811031445.00963.matthias.fuchs@esd-electronics.com>
Content-Type: text/plain
Date: Tue, 04 Nov 2008 07:19:14 +1100
Message-Id: <1225743554.8004.257.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I will try to add endpoint support for PCI as well. I would like to have a single PCI node and
> let the device_type attribute decide if we are running in hostbridge or endpoint mode.

Don't use device_type. Do the same we do for PCI-E (whatever it is, I
don't have the source code at hand right now).

Cheers,
Ben.
