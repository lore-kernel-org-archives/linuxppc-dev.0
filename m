Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.231])
	by ozlabs.org (Postfix) with ESMTP id 80C6CDDE21
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 01:06:19 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2535834rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 07:06:18 -0700 (PDT)
Message-ID: <9e4733910810280706n17bd94d7g7395b4e8beaa149a@mail.gmail.com>
Date: Tue, 28 Oct 2008 10:06:18 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH] fix i2c on PPC linkstation / kurobox machines
In-Reply-To: <ED4FCA66-6032-4F4A-958C-8FD7DDB7CBE9@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081022191650.GA11406@weiser.dinsnail.net>
	<Pine.LNX.4.64.0810232029380.9657@axis700.grange>
	<20081023213309.GA19777@weiser.dinsnail.net>
	<Pine.LNX.4.64.0810240059170.9657@axis700.grange>
	<ED4FCA66-6032-4F4A-958C-8FD7DDB7CBE9@kernel.crashing.org>
Cc: Michael Weiser <michael@weiser.dinsnail.net>,
	=?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>,
	linuxppc-dev@ozlabs.org, Scott Wood <scottwood@freescale.com>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 28, 2008 at 9:58 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Oct 23, 2008, at 6:05 PM, Guennadi Liakhovetski wrote:
>
>> i2c is broken on linkstation / kurobox machines since at least 2.6.27. Fix
>> it. Also remove CONFIG_SERIAL_OF_PLATFORM, which, if enabled, breaks the
>> serial console after the "console handover: boot [udbg0] -> real [ttyS1]"
>> message.
>>
>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>>
>> ---
>>
>> No, I do not really understand why I have to remove
>> CONFIG_SERIAL_OF_PLATFORM now after adding a call to
>> of_platform_bus_probe(), but it works this way. It must have something to
>> do with the legacy serial driver... If accepted in this form, I'll also
>> forward it to stable.
>>
>> diff --git
>
>
> applied to merge.

Did you change the comment? I2C wasn't broken, the bus definition was broken.


>
> - k
>



-- 
Jon Smirl
jonsmirl@gmail.com
