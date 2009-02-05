Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id EC444DDDE3
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2009 06:04:05 +1100 (EST)
Date: Thu, 5 Feb 2009 22:04:03 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: FSL eSDHC bindings update
Message-ID: <20090205190403.GA27976@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 22, 2009 at 01:15:01PM -0600, Kumar Gala wrote:
> On Jan 21, 2009, at 8:00 PM, Anton Vorontsov wrote:
>> This patch adds a new driver: sdhci-of. The driver is similar to
>> the sdhci-pci, it contains common probe code, and controller-specific
>> ops and quirks.
>>
>> So far there are only Freescale eSDHC ops and quirks.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>> drivers/mmc/host/Kconfig    |   10 ++
>> drivers/mmc/host/Makefile   |    1 +
>> drivers/mmc/host/sdhci-of.c |  274 ++++++++++++++++++++++++++++++++++ 
>> +++++++++
>> 3 files changed, 285 insertions(+), 0 deletions(-)
>> create mode 100644 drivers/mmc/host/sdhci-of.c
>
> Still griping about lack of OF binding docs for this.

Here they're.

I'm assuming that MPC8536 is the first chip in 85xx family with eSDHC.


Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
