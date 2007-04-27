Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DCC59DDF88
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 19:25:19 +1000 (EST)
Subject: Re: [PATCH] powerpc: Show current speed in /proc/cpuinfo
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <4631BBB1.9010705@genesi-usa.com>
References: <20070427084118.GA8842@lixom.net> <4631BBB1.9010705@genesi-usa.com>
Content-Type: text/plain
Date: Fri, 27 Apr 2007 19:25:11 +1000
Message-Id: <1177665911.14873.322.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Would it not be relevant to keep listing the maximum CPU speed as well
> as the real, current CPU speed?

Probably not in cpuinfo... there's already a place for that in sysfs.

Ben.
