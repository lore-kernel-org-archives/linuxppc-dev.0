Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <49EC39D6.8020404@grandegger.com>
References: <20090407082052.477328750@denx.de>
	<53B42D49-C040-442E-8448-7BC3190220A5@kernel.crashing.org>
	<F4E3E1FF-C544-460A-AC27-DB9501C13ED3@kernel.crashing.org>
	<49DC515F.3040100@grandegger.com>
	<E9E24C93-F147-49F0-9FBE-FCE4883D11BF@kernel.crashing.org>
	<49DD0144.7050902@grandegger.com> <49DDC718.8000706@grandegger.com>
	<49EC39D6.8020404@grandegger.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 20 Apr 2009 07:26:14 -0600
Message-ID: <fa686aa40904200626s71e2891u6148471c6682d08e@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] i2c: i2c-mpc: make I2C bus speed configurable
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	devicetree-discuss <devicetree-discuss@ozlabs.org>,
	linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 20, 2009 at 3:01 AM, Wolfgang Grandegger <wg@grandegger.com> wr=
ote:
> Hi Ben,
>
> Wolfgang Grandegger wrote:
>> Wolfgang Grandegger wrote:
>>> Kumar Gala wrote:
>>>> On Apr 8, 2009, at 2:25 AM, Wolfgang Grandegger wrote:
>>>>
>>>>>> So I'm a bit concerned with the output we now get:
>>>>>>
>>>>>> mpc-i2c fffe03000.i2c: clock 0 Hz (dfsrr=3D16 fdr=3D49)
>>>>>>
>>>>>> why 0? is that right?
>>>>> This is the backward compatibility mode using hard-coded FDR values. =
The
>>>>> output is missleading, I agree.
>>>>>
>>>>> Wolfgang.
>>>> Can the output be fixed. =A00 Hz seemed bad to me.
>>> Of course. No info message will be printed for the legacy case
>>> like it was with the old driver version. I just realized a bug in the
>>> MPC52xx part. Will send patches tomorrow, after some more thorough test=
ing.
>>
>> The patch below fixes both issues. Ben, could you please apply it. Sorry=
 for
>> the inconvenience caused.
>>
>> Thanks,
>>
>> Wolfgang.
>>
>>
>>
>> [PATCH] i2c: i2c-mpc: bug fix for MPC52xx clock setting and printout
>>
>> The clock setting did not work for the MPC52xx due to a stupid bug.
>> Furthermore, the dev info output "clock=3D0" for old device trees was
>> misleading. This patch fixes both issues.
>>
>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>
> Could you please apply this bug-fix for the MPC driver for 2.6.30.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

>
> =A0http://marc.info/?l=3Dlinux-i2c&m=3D123927120910293&w=3D2
>
> Thanks,
>
> Wolfgang.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
