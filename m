Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 10E57DDEE7
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 01:46:09 +1000 (EST)
In-Reply-To: <20070827154426.GA10453@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0708271025170.15438@blarg.am.freescale.net>
	<20070827154426.GA10453@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <26709A38-27D1-4342-9763-88D5B359858E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 85xx: Renamed mpc8544_ds.c to mpc85xx_ds.c
Date: Mon, 27 Aug 2007 10:48:19 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 27, 2007, at 10:44 AM, Scott Wood wrote:

> On Mon, Aug 27, 2007 at 10:25:53AM -0500, Kumar Gala wrote:
>> diff --git a/arch/powerpc/platforms/85xx/mpc8544_ds.c b/arch/ 
>> powerpc/platforms/85xx/mpc8544_ds.c
>> deleted file mode 100644
>> index 0f834d8..0000000
>> --- a/arch/powerpc/platforms/85xx/mpc8544_ds.c
>> +++ /dev/null
>> @@ -1,186 +0,0 @@
>> -/*
>> - * MPC8544 DS Board Setup
>> - *
> [snip]
>> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/ 
>> powerpc/platforms/85xx/mpc85xx_ds.c
>> new file mode 100644
>> index 0000000..0f834d8
>> --- /dev/null
>> +++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
>> @@ -0,0 +1,186 @@
>> +/*
>> + * MPC8544 DS Board Setup
>> + *
>
> If you pass -M to git-format-patch, it'll detect renames rather than
> showing a large delete followed by a large create.

thanks, will do that in the future. :)

- k
