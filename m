Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 95D1CDDEDE
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 06:54:17 +1000 (EST)
Message-ID: <4713D3D6.6070203@genesi-usa.com>
Date: Mon, 15 Oct 2007 21:55:50 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 4/7] bestcomm: core bestcomm support for Freescale
	MPC5200
References: <20071014044041.23438.14070.stgit@trillian.cg.shawcable.net>		<20071014044205.23438.36036.stgit@trillian.cg.shawcable.net>		<4713551B.9040103@genesi-usa.com>	<fa686aa40710150704j15f3a511rf5924573282c966b@mail.gmail.com>
	<4713D35A.9080200@genesi-usa.com>
In-Reply-To: <4713D35A.9080200@genesi-usa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Matt Sealey wrote:

> call a PSC, we wouldn't be making structures called mpc52xx_programmable_serial_controller,
> that's redundant, I don't think calling it "bestcomm" (which is it's name) over
> "bcom" (which isn't) works to anyone's advantage here.

Disadvantage, even. Damn autocorrecting :(

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
