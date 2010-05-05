Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B79E0B7D47
	for <linuxppc-dev@ozlabs.org>; Thu,  6 May 2010 01:59:49 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o45Fxkag004277
	for <linuxppc-dev@ozlabs.org>; Wed, 5 May 2010 08:59:46 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o45GAAVZ027014
	for <linuxppc-dev@ozlabs.org>; Wed, 5 May 2010 11:10:10 -0500 (CDT)
Message-ID: <4BE195F0.9070400@freescale.com>
Date: Wed, 05 May 2010 10:59:44 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc/8610: add probing for individual
	DMA channels, not just DMA controllers
References: <1272923655-31807-1-git-send-email-timur@freescale.com>
	<2928D88F-057B-498C-8A11-F7193429A90D@freescale.com>
	<20100505112208.GD5754@opensource.wolfsonmicro.com>
	<g2ied82fe3e1005050439v70066822h7518ac53f97e97f6@mail.gmail.com>
	<20100505123545.GA7139@rakim.wolfsonmicro.main>
In-Reply-To: <20100505123545.GA7139@rakim.wolfsonmicro.main>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>,
	alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mark Brown wrote:
> On Wed, May 05, 2010 at 06:39:01AM -0500, Timur Tabi wrote:
>> On Wed, May 5, 2010 at 6:22 AM, Mark Brown
> 
>>> Just looking at the scheduling here with regard to the merge window and
>>> the fact that this doesn't seem to hurt the existing drivers perhaps it
>>> makes sense to merge this via the PowerPC tree immediately?
> 
>> Aren't we a little late in the cycle for a patch that doesn't do anything?
> 
> It seems to be safe enough for -next.

Sure, -next is fine.

-- 
Timur Tabi
Linux kernel developer at Freescale
