Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6ED8C679E1
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Sep 2006 17:11:43 +1000 (EST)
Subject: Re: AC power not detected if no battery present
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20060924064008.GA7925@aepfle.de>
References: <20060924064008.GA7925@aepfle.de>
Content-Type: text/plain
Date: Sun, 24 Sep 2006 17:11:28 +1000
Message-Id: <1159081888.5924.20.camel@localhost.localdomain>
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

On Sun, 2006-09-24 at 08:40 +0200, Olaf Hering wrote:
> PMU_PWR_AC_PRESENT in pmu_power_flags is never set if booted without
> battery. This leads to 'AC Power' == 0 in /proc/pmu/info.
> How can this be fixed properly?

Maybe simply buy forcing it when there is no battery ? I fail to see how
the machine could be up without battery _and_ without AC :)

Ben.
