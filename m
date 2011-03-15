Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1AC9FB6FBB
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2011 02:44:56 +1100 (EST)
Subject: Re: [PATCH] I2C: Add support for 64bit system.
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20101220145954.GA1126@trinity.fluff.org>
Date: Tue, 15 Mar 2011 10:44:30 -0500
Message-Id: <D9BF0938-44B1-4BB8-BF3C-0A9CB44B9CC5@kernel.crashing.org>
References: <1292830654-7056-1-git-send-email-B33228@freescale.com>
	<20101220145954.GA1126@trinity.fluff.org>
To: Ben Dooks <ben-i2c@fluff.org>
Cc: Xulei <B33228@freescale.com>, linux-i2c@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 20, 2010, at 8:59 AM, Ben Dooks wrote:

> On Mon, Dec 20, 2010 at 03:37:34PM +0800, Xulei wrote:
>> Currently I2C_MPC supports 32bit system only, then this
>> modification makes it support 32bit and 64bit system both.
>> 
>> Signed-off-by: Xulei <B33228@freescale.com>
> 
> This been build or run tested?

Yes, Any issues with me applying this via the powerpc.git tree?

> 
>> ---
>> drivers/i2c/busses/Kconfig |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>> 
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index 9c6170c..3392f4b 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -422,7 +422,7 @@ config I2C_IXP2000
>> 
>> config I2C_MPC
>> 	tristate "MPC107/824x/85xx/512x/52xx/83xx/86xx"
>> -	depends on PPC32
>> +	depends on PPC32 || PPC64
>> 	help
>> 	  If you say yes to this option, support will be included for the
>> 	  built-in I2C interface on the MPC107, Tsi107, MPC512x, MPC52xx,
>> -- 
>> 1.7.0.4
>> 
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/
> 
> Large Hadron Colada: A large Pina Colada that makes the universe disappear.
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
