Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 80387DDE30
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 12:06:28 +1000 (EST)
Subject: Re: [PATCH 1/2] adb: create class devices for each adb device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Aristeu Rozanski <aris@ruivo.org>
In-Reply-To: <20070717013022.GB20841@cathedrallabs.org>
References: <20070716205319.GC30232@cathedrallabs.org>
	<1184628153.25235.111.camel@localhost.localdomain>
	<20070717013022.GB20841@cathedrallabs.org>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 12:06:22 +1000
Message-Id: <1184637982.25235.117.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> or maybe generate disconnect/connect events so udev rules can reconfigure
> each keyboard?

Possibly... That would be obtained by just removing/re-adding the
devices (CONFIG_HOTPLUG is necessary to get the infrastructure for that
afaik).

Ben.
