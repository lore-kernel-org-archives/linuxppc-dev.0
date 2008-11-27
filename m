Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id D3C3FDDDFB
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 02:43:46 +1100 (EST)
Message-ID: <492EC031.9000802@matrix-vision.de>
Date: Thu, 27 Nov 2008 16:43:45 +0100
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: i2c-mpc clocking scheme
References: <492EB606.9020703@matrix-vision.de>
	<ed82fe3e0811270724t26d2a8e2v233143722eb8587f@mail.gmail.com>
In-Reply-To: <ed82fe3e0811270724t26d2a8e2v233143722eb8587f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi schrieb:
> On Thu, Nov 27, 2008 at 9:00 AM, Andre Schwarz
> <andre.schwarz@matrix-vision.de> wrote:
>   
>> All,
>>
>> is anybody working on some improvements regarding configurable I2C
>> frequency inside the i2c-mpc driver ?
>>
>> If not - would anybody be intersted in getting this done, i.e.
>> configurable via device tree ?
>>     
>
> Maybe I'm missing something, but U-Boot configures the I2C bus speed.
> It does this because the algorithm is specific to the SOC itself.  For
> example, the 8544 is different from the 8548.  It would be a mess to
> duplicate this code in the kernel.
>
>   
You're right regarding U-Boot, but the i2c-mpc driver overwrites the
"frequency divider register" on all chips.

I'm not happy with a fixed 0x3f @ MPC5200 which results in 65kHz ... :-(

Have a look at line 163 in drivers/i2c/busses/i2c-mpc.c



MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
