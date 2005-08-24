Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 49E7E680E0
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Aug 2005 08:34:07 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20050824115452.GA29148@suse.de>
References: <20050824115452.GA29148@suse.de>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 08:32:51 +1000
Message-Id: <1124922771.5159.134.camel@gaston>
Mime-Version: 1.0
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

On Wed, 2005-08-24 at 13:54 +0200, Olaf Hering wrote:
> My G4/450 runs without AC Power, according to /proc/pmu/info:
> 
> PMU driver version     : 2
> PMU firmware version   : 0c
> AC Power               : 0
> Battery count          : 0
> 
> It should report 1. Where is the best place to get the
> PMU_PWR_AC_PRESENT into ac_line_status?

Do we get the bit set from the PMU ? If not, maybe we should hard code
that value on non-laptops

Ben.
