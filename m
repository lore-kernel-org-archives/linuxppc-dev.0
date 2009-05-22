Return-Path: <jonsmirl@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id C2707DE1E4
	for <linuxppc-dev@ozlabs.org>; Sat, 23 May 2009 02:06:36 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so1069226qwe.15
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 09:06:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40905220833m56e7d705n8105813b615df24e@mail.gmail.com>
References: <20090522152510.20037.26911.stgit@terra>
	<fa686aa40905220833m56e7d705n8105813b615df24e@mail.gmail.com>
Date: Fri, 22 May 2009 12:06:31 -0400
Message-ID: <9e4733910905220906j4b61e4detded8def7ebc0bd0f@mail.gmail.com>
Subject: Re: [PATCH] Add a few more mpc5200 PSC defines
From: Jon Smirl <jonsmirl@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
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

On Fri, May 22, 2009 at 11:33 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Fri, May 22, 2009 at 9:25 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
>> Add a few more mpc5200 PSC defines. More bit fields defines for mpc5200 =
PSC registers
>>
>> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
>
> Thanks Jon,
>
> What are you adding these defines for (so I can add it to the commit log)=
?

AC97 support

>
> g.
>
>> ---
>> =A0arch/powerpc/include/asm/mpc52xx_psc.h | =A0 11 +++++++++++
>> =A01 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/mpc52xx_psc.h b/arch/powerpc/inclu=
de/asm/mpc52xx_psc.h
>> index a218da6..fb84120 100644
>> --- a/arch/powerpc/include/asm/mpc52xx_psc.h
>> +++ b/arch/powerpc/include/asm/mpc52xx_psc.h
>> @@ -28,6 +28,10 @@
>> =A0#define MPC52xx_PSC_MAXNUM =A0 =A0 6
>>
>> =A0/* Programmable Serial Controller (PSC) status register bits */
>> +#define MPC52xx_PSC_SR_UNEX_RX 0x0001
>> +#define MPC52xx_PSC_SR_DATA_VAL =A0 =A0 =A0 =A00x0002
>> +#define MPC52xx_PSC_SR_DATA_OVR =A0 =A0 =A0 =A00x0004
>> +#define MPC52xx_PSC_SR_CMDSEND 0x0008
>> =A0#define MPC52xx_PSC_SR_CDE =A0 =A0 0x0080
>> =A0#define MPC52xx_PSC_SR_RXRDY =A0 0x0100
>> =A0#define MPC52xx_PSC_SR_RXFULL =A00x0200
>> @@ -61,6 +65,12 @@
>> =A0#define MPC52xx_PSC_RXTX_FIFO_EMPTY =A0 =A00x0001
>>
>> =A0/* PSC interrupt status/mask bits */
>> +#define MPC52xx_PSC_IMR_UNEX_RX_SLOT 0x0001
>> +#define MPC52xx_PSC_IMR_DATA_VALID =A0 =A0 0x0002
>> +#define MPC52xx_PSC_IMR_DATA_OVR =A0 =A0 =A0 0x0004
>> +#define MPC52xx_PSC_IMR_CMD_SEND =A0 =A0 =A0 0x0008
>> +#define MPC52xx_PSC_IMR_ERROR =A0 =A0 =A0 =A0 =A00x0040
>> +#define MPC52xx_PSC_IMR_DEOF =A0 =A0 =A0 =A0 =A0 0x0080
>> =A0#define MPC52xx_PSC_IMR_TXRDY =A0 =A0 =A0 =A0 =A00x0100
>> =A0#define MPC52xx_PSC_IMR_RXRDY =A0 =A0 =A0 =A0 =A00x0200
>> =A0#define MPC52xx_PSC_IMR_DB =A0 =A0 =A0 =A0 =A0 =A0 0x0400
>> @@ -117,6 +127,7 @@
>> =A0#define MPC52xx_PSC_SICR_SIM_FIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x6 << =
24)
>> =A0#define MPC52xx_PSC_SICR_SIM_CODEC_24 =A0 =A0 =A0 =A0 =A0(0x7 << 24)
>> =A0#define MPC52xx_PSC_SICR_SIM_CODEC_32 =A0 =A0 =A0 =A0 =A0(0xf << 24)
>> +#define MPC52xx_PSC_SICR_AWR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << =
30)
>> =A0#define MPC52xx_PSC_SICR_GENCLK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 23)
>> =A0#define MPC52xx_PSC_SICR_I2S =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 <=
< 22)
>> =A0#define MPC52xx_PSC_SICR_CLKPOL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 21)
>>
>>
>
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



--=20
Jon Smirl
jonsmirl@gmail.com
