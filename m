Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 11A15DDF65
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 01:16:30 +1000 (EST)
Date: Tue, 27 May 2008 19:16:28 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/7] [POWERPC] QE: implement support for the GPIO LIB API
Message-ID: <20080527151628.GA11517@polina.dev.rtsoft.ru>
References: <20080523163811.GA12181@polina.dev.rtsoft.ru>
	<20080523163900.GD16137@polina.dev.rtsoft.ru>
	<8E7E138E-E6D7-45FA-885F-380A82ECEC63@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <8E7E138E-E6D7-45FA-885F-380A82ECEC63@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 27, 2008 at 10:04:20AM -0500, Kumar Gala wrote:
>
> On May 23, 2008, at 11:39 AM, Anton Vorontsov wrote:
>
>> This is needed to access QE GPIOs via Linux GPIO API.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> Acked-By: Timur Tabi <timur@freescale.com>
>> ---
>> Documentation/powerpc/booting-without-of.txt |   27 +++++
>> arch/powerpc/sysdev/qe_lib/Kconfig           |    9 ++
>> arch/powerpc/sysdev/qe_lib/Makefile          |    1 +
>> arch/powerpc/sysdev/qe_lib/gpio.c            |  148 +++++++++++++++++ 
>> +++++++++
>> include/asm-powerpc/qe.h                     |    2 +
>> 5 files changed, 187 insertions(+), 0 deletions(-)
>> create mode 100644 arch/powerpc/sysdev/qe_lib/gpio.c
>
> didn't we talk about putting this is drivers/gpio/ ?

:-)

Yes, we did. And David Brownell politely suggested to not do this,
and instead leave it in arch/ as do all other arches for their SOC
GPIOs.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
