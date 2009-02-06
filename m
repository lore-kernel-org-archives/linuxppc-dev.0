Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 376A7DDF04
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2009 13:53:02 +1100 (EST)
Message-Id: <A7909298-D656-4BDE-BB02-0D6A8036045D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090205190403.GA27976@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: FSL eSDHC bindings update
Date: Thu, 5 Feb 2009 20:52:56 -0600
References: <20090205190403.GA27976@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 5, 2009, at 1:04 PM, Anton Vorontsov wrote:

> On Thu, Jan 22, 2009 at 01:15:01PM -0600, Kumar Gala wrote:
>> On Jan 21, 2009, at 8:00 PM, Anton Vorontsov wrote:
>>> This patch adds a new driver: sdhci-of. The driver is similar to
>>> the sdhci-pci, it contains common probe code, and controller- 
>>> specific
>>> ops and quirks.
>>>
>>> So far there are only Freescale eSDHC ops and quirks.
>>>
>>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>>> ---
>>> drivers/mmc/host/Kconfig    |   10 ++
>>> drivers/mmc/host/Makefile   |    1 +
>>> drivers/mmc/host/sdhci-of.c |  274 ++++++++++++++++++++++++++++++++ 
>>> ++
>>> +++++++++
>>> 3 files changed, 285 insertions(+), 0 deletions(-)
>>> create mode 100644 drivers/mmc/host/sdhci-of.c
>>
>> Still griping about lack of OF binding docs for this.
>
> Here they're.
>
> I'm assuming that MPC8536 is the first chip in 85xx family with eSDHC.

thanks.  MPC8536 is the first.  Do we need a u-boot patch for clock- 
frequency on 85xx?

- k
