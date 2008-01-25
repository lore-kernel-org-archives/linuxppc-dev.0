Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 22AADDDED8
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 11:46:26 +1100 (EST)
Message-ID: <479A26C0.7010704@freescale.com>
Date: Fri, 25 Jan 2008 12:13:20 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Aggrwal Poonam <Poonam.Aggrwal@freescale.com>
Subject: Re: [PATCH UCC TDM 3/3 ] Modified Documentation to explain dtsentries
	for TDM driver
References: <FBA61160C48B8D438F3323FEFB4EF2C279AFF5@zin33exm24.fsl.freescale.net>
In-Reply-To: <FBA61160C48B8D438F3323FEFB4EF2C279AFF5@zin33exm24.fsl.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Barkowski Michael <Michael.Barkowski@freescale.com>, netdev@vger.kernel.org,
	Gala Kumar <kumar.gala@freescale.com>,
	linux-kernel@vger.kernel.org, rubini@vision.unipv.it,
	linuxppc-dev@ozlabs.org, Kalra Ashish <ashish.kalra@freescale.com>,
	Cutler Richard <Rich.Cutler@freescale.com>,
	akpm@linux-foundation.org, Tabi Timur <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Aggrwal Poonam wrote:
> The device tree already has a brg-frequency  property in qe node which
> is the value of BRGCLK. 

Yes, I'm saying it belongs as brg/clock-frequency. :-)
CPM1/2 already do this.

-Scott
