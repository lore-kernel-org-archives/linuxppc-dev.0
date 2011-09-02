Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AEFD7B6F7B
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Sep 2011 13:35:37 +1000 (EST)
Subject: Re: [PATCH 1/4] powerpc/85xx: Rename PowerPC core nodes to match
	other e500mc based .dts
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAOZdJXUfgkvCCgW-KEgGJ0wW+EyGnhf+=aLV7E4SsKBoztP7uQ@mail.gmail.com>
Date: Thu, 1 Sep 2011 22:35:34 -0500
Message-Id: <F94709B7-1623-4DAC-8BE7-98DB3ABEEDDB@kernel.crashing.org>
References: <1314905175-4371-1-git-send-email-galak@kernel.crashing.org>
	<CAOZdJXUfgkvCCgW-KEgGJ0wW+EyGnhf+=aLV7E4SsKBoztP7uQ@mail.gmail.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 1, 2011, at 5:33 PM, Tabi Timur-B04825 wrote:

> On Thu, Sep 1, 2011 at 2:26 PM, Kumar Gala <galak@kernel.crashing.org> =
wrote:
>> The P4080 silicon device tree was using PowerPC,4080 while the other
>> e500mc based SoCs used PowerPC,e500mc.  Use the core name to be
>> consistent going forward.
>=20
> Shouldn't we change the nodes for all e500 based device trees in one
> shot, instead of just the P4080?

I changed all the e500mc class to match what is used by everyone else.  =
The e500v1/e500v2 are use the same convention at this time so figured a =
separate patch can handle them.

- k=
