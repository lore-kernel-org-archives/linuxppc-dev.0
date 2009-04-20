Return-Path: <wg@grandegger.com>
Message-ID: <49EC39D6.8020404@grandegger.com>
Date: Mon, 20 Apr 2009 11:01:10 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH v3 0/5] i2c: i2c-mpc: make I2C bus speed configurable
References: <20090407082052.477328750@denx.de>	<53B42D49-C040-442E-8448-7BC3190220A5@kernel.crashing.org>	<F4E3E1FF-C544-460A-AC27-DB9501C13ED3@kernel.crashing.org>	<49DC515F.3040100@grandegger.com>	<E9E24C93-F147-49F0-9FBE-FCE4883D11BF@kernel.crashing.org>
	<49DD0144.7050902@grandegger.com> <49DDC718.8000706@grandegger.com>
In-Reply-To: <49DDC718.8000706@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	devicetree-discuss <devicetree-discuss@ozlabs.org>,
	linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

Wolfgang Grandegger wrote:
> Wolfgang Grandegger wrote:
>> Kumar Gala wrote:
>>> On Apr 8, 2009, at 2:25 AM, Wolfgang Grandegger wrote:
>>>
>>>>> So I'm a bit concerned with the output we now get:
>>>>>
>>>>> mpc-i2c fffe03000.i2c: clock 0 Hz (dfsrr=16 fdr=49)
>>>>>
>>>>> why 0? is that right?
>>>> This is the backward compatibility mode using hard-coded FDR values. The
>>>> output is missleading, I agree.
>>>>
>>>> Wolfgang.
>>> Can the output be fixed.  0 Hz seemed bad to me.
>> Of course. No info message will be printed for the legacy case
>> like it was with the old driver version. I just realized a bug in the
>> MPC52xx part. Will send patches tomorrow, after some more thorough testing.
> 
> The patch below fixes both issues. Ben, could you please apply it. Sorry for
> the inconvenience caused.
> 
> Thanks,
> 
> Wolfgang.
> 
> 
> 
> [PATCH] i2c: i2c-mpc: bug fix for MPC52xx clock setting and printout
> 
> The clock setting did not work for the MPC52xx due to a stupid bug.
> Furthermore, the dev info output "clock=0" for old device trees was
> misleading. This patch fixes both issues.
> 
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>

Could you please apply this bug-fix for the MPC driver for 2.6.30.

  http://marc.info/?l=linux-i2c&m=123927120910293&w=2

Thanks,

Wolfgang.
