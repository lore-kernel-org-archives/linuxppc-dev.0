Return-Path: <tnt@246tNt.com>
Received: from outmx012.isp.belgacom.be (outmx012.isp.belgacom.be
	[195.238.5.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 402D7DDECD
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 20:02:51 +1100 (EST)
Received: from outmx012.isp.belgacom.be (localhost [127.0.0.1])
	by outmx012.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l0C92gNB019647
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 10:02:42 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45A74E2F.2000901@246tNt.com>
Date: Fri, 12 Jan 2007 10:00:31 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] add restart function for mpc52xx
References: <20070111122855.GF11226@localhost.localdomain>	<37B2A6BB-4F36-4765-A1C2-A4F8D30D4503@kernel.crashing.org>	<20070111152137.GG11226@localhost.localdomain>	<17831.627.162751.166002@cargo.ozlabs.ibm.com>
	<20070112084612.GJ11226@localhost.localdomain>
In-Reply-To: <20070112084612.GJ11226@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sascha Hauer wrote:
>> Not being able to ioremap at interrupt time has absolutely _nothing_
>> to do with the device tree.
>>     
>
> No, not directly..
>   
Not at all ... in arch/ppc we just have the bug and just never noticed.

> On system with real open firmware it's surely the way to go to use it,
> but on systems without OF it's just painful. Not being able to implement
> a restart function without changing the device tree shows that.
>   
It's because the device tree is not done correctly ... The bindings are
recent,
and may change soon. This whole issue has triggered some discussion on IRC
about them.

I'm not saying the system is perfect but this issue is more related to
recent
bindings that the of thing as a whole. That's more the problem with of
is that
when you need to define bindings for something that has none, you may not
anticipate everything ....

    Sylvain
