Return-Path: <THagen@oslo.westerngeco.slb.com>
Received: from mail.slb.com (eurmta01.london.eur.slb.com [134.32.26.55])
	by ozlabs.org (Postfix) with ESMTP id 9B64F679F5
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Jun 2005 16:51:21 +1000 (EST)
Received: from pmxchannel_int-daemon.eurmta01.london.eur.slb.com by
	eurmta01.london.eur.slb.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	id <0IHN00101H93OC@eurmta01.london.eur.slb.com> for
	linuxppc-embedded@ozlabs.org; Mon, 06 Jun 2005 06:41:27 +0000 (GMT)
Received: from wgmail3.oslo.eur.slb.com
	(wgmail3.oslo.eur.slb.com [134.32.44.153]) by
	eurmta01.london.eur.slb.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0IHN00HSGH929N@eurmta01.london.eur.slb.com> for
	linuxppc-embedded@ozlabs.org; Mon, 06 Jun 2005 06:41:26 +0000 (GMT)
Received: from [134.32.140.197] (localhost [127.0.0.1])
	by wgmail3.oslo.eur.slb.com (Switch-2.2.8/8.11.1) with ESMTP id
	j566fOE15390 for <linuxppc-embedded@ozlabs.org>;
	Mon, 06 Jun 2005 08:41:24 +0200 (MEST)
Date: Mon, 06 Jun 2005 08:41:25 +0200
From: Tore Martin Hagen <THagen@oslo.westerngeco.slb.com>
In-reply-to: <BAY1-DAV469FED545DEDB9CFE00498BFB0@phx.gbl>
To: LinuxPPC Support <linuxppc-embedded@ozlabs.org>
Message-id: <42A3F015.5020203@oslo.westerngeco.slb.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <BAY1-DAV469FED545DEDB9CFE00498BFB0@phx.gbl>
Subject: Reseting bootcount from linux
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am using a MPC8266ADS-PCI board and u-boot with the
CONFIG_BOOTCOUNT_LIMIT. If i stop u-boot before it starts Linux I can
see that the bootcount variable increments nicely. But if i dump the 
content from flash (dd if=/dev/mtd/1 of=a1out bs=1k) and check the 
content it is always
bootcount=1

So how can I reset the bootcount if it is always 1, or rather where is
the real bootcount stored?

/Tore

**
