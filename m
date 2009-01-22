Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 00E33DDF0F
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 12:35:38 +1100 (EST)
Date: Thu, 22 Jan 2009 04:35:36 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] mmc: Add driver for Freescale eSDHC controllers
Message-ID: <20090122013536.GA6008@oksana.dev.rtsoft.ru>
References: <20090114194631.GA25978@oksana.dev.rtsoft.ru>
	<533AEE7C-0605-43E9-BB9F-615BE6761202@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <533AEE7C-0605-43E9-BB9F-615BE6761202@kernel.crashing.org>
Cc: Joe D'Abbraccio <Joe.D'abbraccio@freescale.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Xie Xiaobo <X.Xie@freescale.com>, Konjin Lai <Konjin.Lai@freescale.com>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 14, 2009 at 09:43:50PM -0600, Kumar Gala wrote:
>
> On Jan 14, 2009, at 1:46 PM, Anton Vorontsov wrote:
>
>> From: Xie Xiaobo <X.Xie@freescale.com>
>>
>> This patch adds support for the Freescale Enhanced Secure Digital
>> Host Controller Interface as found in some Freescale PowerPC
>> microprocessors (e.g. MPC837x SOCs).
>>
>> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
>> Signed-off-by: Konjin Lai <Konjin.Lai@freescale.com>
>> Signed-off-by: Joe D'Abbraccio <Joe.D'abbraccio@freescale.com>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>> drivers/mmc/host/Kconfig  |    9 +
>> drivers/mmc/host/Makefile |    1 +
>> drivers/mmc/host/esdhc.c  | 1321 ++++++++++++++++++++++++++++++++++++ 
>> +++++++++
>> drivers/mmc/host/esdhc.h  |  255 +++++++++
>> 4 files changed, 1586 insertions(+), 0 deletions(-)
>> create mode 100644 drivers/mmc/host/esdhc.c
>> create mode 100644 drivers/mmc/host/esdhc.h
>
> Want to work some device tree docs for this.

Will do. Though all the needed nodes already in the .dts files. ;-)

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
