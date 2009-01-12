Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6872ADE2EF
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 02:10:22 +1100 (EST)
Message-Id: <27159C32-9F05-4E21-98CE-0F157934D14B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20090111181055.31611474@hyperion.delvare>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/83xx: Move mcu_mpc8349emitx driver out of
	drivers/i2c/chips/
Date: Mon, 12 Jan 2009 09:10:02 -0600
References: <20090111165136.GA26096@oksana.dev.rtsoft.ru>
	<20090111181055.31611474@hyperion.delvare>
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 11, 2009, at 11:10 AM, Jean Delvare wrote:

> Hi Anton,
>
> On Sun, 11 Jan 2009 19:51:36 +0300, Anton Vorontsov wrote:
>> This patch is used to help Jean Delvare to get rid of drivers/i2c/ 
>> chips/
>> directory. The new location suggested by Kumar Gala: as the driver is
>> 83xx specific it's placed into arch/powerpc/platforms/83xx/.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>
> Thanks for doing this. Do you expect me to take this patch in my i2c
> tree, or will it go in some powerpc tree?

I'll pick this up.

- k
