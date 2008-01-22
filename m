Return-Path: <joshua.williams@qlogic.com>
Received: from EPEXCH1.qlogic.org (eppat.qlogic.com [198.186.5.11])
	by ozlabs.org (Postfix) with ESMTP id E0A1CDDE1E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 04:07:16 +1100 (EST)
Message-ID: <47962316.8040709@qlogic.com>
Date: Tue, 22 Jan 2008 11:08:38 -0600
From: Joshua Williams <joshua.williams@qlogic.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH] Various new ibm405 DCRN #defines
References: <47952018.7050702@qlogic.com> <1200956274.6807.12.camel@pasglop>
In-Reply-To: <1200956274.6807.12.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Mon, 2008-01-21 at 16:43 -0600, Joshua Williams wrote:
>> Various new ibm405 DCRN #defines.
>>
>>      Signed-off-by: Joshua Williams <joshua.williams@qlogic.com>
> 
> May I ask what for ? :-) Also, it's all arch/ppc, not arch/powerpc...
> nothing we want to improve to much on at this stage unless there's a
> really good reason.

The 405x #defines were incomplete and this was meant to
make them a bit tighter.  Since arch/ppc is in life support
mode this can wait until the 405x stuff gets moved over to
arch/powerpc.

Thanks!

- Josh

>> ---
>>   arch/ppc/platforms/4xx/ibm405ep.h  |    3 +++
>>   arch/ppc/platforms/4xx/ibm405gp.h  |    9 +++++++++
>>   arch/ppc/platforms/4xx/ibm405gpr.h |    9 +++++++++
>>   include/asm-ppc/ibm405.h           |   27 +++++++++++++++++++++++++++
>>   4 files changed, 48 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/ppc/platforms/4xx/ibm405ep.h 
>> b/arch/ppc/platforms/4xx/ibm405ep.h
>> index 3ef20a5..d82a4c7 100644
>> --- a/arch/ppc/platforms/4xx/ibm405ep.h
>> +++ b/arch/ppc/platforms/4xx/ibm405ep.h
>> @@ -139,6 +139,9 @@
>>   #define DCRN_UIC0_BASE          0x0C0
>>   #define UIC0 DCRN_UIC0_BASE
>>
>> +/* DCRN_SDRAM0_BASE offsets - general 405 offsets in asm/ibm405.h */
>> +#define DCRN_SDRAM0_STATUS	0x24	/* SDRAM Controller Status */
>> +
>>   #include <asm/ibm405.h>
>>
>>   #endif				/* __ASM_IBM405EP_H__ */
>> diff --git a/arch/ppc/platforms/4xx/ibm405gp.h 
>> b/arch/ppc/platforms/4xx/ibm405gp.h
>> index 9f15e55..9f7e850 100644
>> --- a/arch/ppc/platforms/4xx/ibm405gp.h
>> +++ b/arch/ppc/platforms/4xx/ibm405gp.h
>> @@ -142,6 +142,15 @@
>>   #define DCRN_UIC0_BASE		0x0C0
>>   #define UIC0 DCRN_UIC0_BASE
>>
>> +/* DCRN_SDRAM0_BASE offsets - general 405 offsets in asm/ibm405.h */
>> +#define DCRN_SDRAM0_BESR0	0x00	/* Bus Error Syndrome Reg 0 */
>> +#define DCRN_SDRAM0_BESR1	0x08	/* Bus Error Syndrome Reg 1 */
>> +#define DCRN_SDRAM0_BEAR	0x10	/* Bus Error Address Reg */
>> +#define DCRN_SDRAM0_B2CR	0x48	/* Memory Bank 2 Configuration Reg */
>> +#define DCRN_SDRAM0_B3CR	0x4c	/* Memory Bank 3 Configuration Reg */
>> +#define DCRN_SDRAM0_ECCCFG	0x94	/* ECC Configuration */
>> +#define DCRN_SDRAM0_ECCESR	0x98	/* ECC Error Status */
>> +
>>   #include <asm/ibm405.h>
>>
>>   #endif				/* __ASM_IBM405GP_H__ */
>> diff --git a/arch/ppc/platforms/4xx/ibm405gpr.h 
>> b/arch/ppc/platforms/4xx/ibm405gpr.h
>> index 9e01f15..6f39042 100644
>> --- a/arch/ppc/platforms/4xx/ibm405gpr.h
>> +++ b/arch/ppc/platforms/4xx/ibm405gpr.h
>> @@ -142,6 +142,15 @@
>>   #define DCRN_UIC0_BASE		0x0C0
>>   #define UIC0 DCRN_UIC0_BASE
>>
>> +/* DCRN_SDRAM0_BASE offsets - general 405 offsets in asm/ibm405.h */
>> +#define DCRN_SDRAM0_BESR0	0x00	/* Bus Error Syndrome Reg 0 */
>> +#define DCRN_SDRAM0_BESR1	0x08	/* Bus Error Syndrome Reg 1 */
>> +#define DCRN_SDRAM0_BEAR	0x10	/* Bus Error Address Reg */
>> +#define DCRN_SDRAM0_B2CR	0x48	/* Memory Bank 2 Configuration Reg */
>> +#define DCRN_SDRAM0_B3CR	0x4c	/* Memory Bank 3 Configuration Reg */
>> +#define DCRN_SDRAM0_ECCCFG	0x94	/* ECC Configuration */
>> +#define DCRN_SDRAM0_ECCESR	0x98	/* ECC Error Status */
>> +
>>   #include <asm/ibm405.h>
>>
>>   #endif				/* __ASM_IBM405GPR_H__ */
>> diff --git a/include/asm-ppc/ibm405.h b/include/asm-ppc/ibm405.h
>> index 4e5be9e..04aaae6 100644
>> --- a/include/asm-ppc/ibm405.h
>> +++ b/include/asm-ppc/ibm405.h
>> @@ -135,6 +135,26 @@
>>   #ifdef DCRN_EBC_BASE
>>   #define DCRN_EBCCFGADR	(DCRN_EBC_BASE + 0x0)	/* Peripheral Controller 
>> Address */
>>   #define DCRN_EBCCFGDATA	(DCRN_EBC_BASE + 0x1)	/* Peripheral Controller 
>> Data */
>> +#define DCRN_EBC_PB0CR	0x00	/* Peripheral Bank 0 Config Reg */
>> +#define DCRN_EBC_PB1CR	0x01	/* Peripheral Bank 1 Config Reg */
>> +#define DCRN_EBC_PB2CR	0x02	/* Peripheral Bank 2 Config Reg */
>> +#define DCRN_EBC_PB3CR	0x03	/* Peripheral Bank 3 Config Reg */
>> +#define DCRN_EBC_PB4CR	0x04	/* Peripheral Bank 4 Config Reg */
>> +#define DCRN_EBC_PB5CR	0x05	/* Peripheral Bank 5 Config Reg */
>> +#define DCRN_EBC_PB6CR	0x06	/* Peripheral Bank 6 Config Reg */
>> +#define DCRN_EBC_PB7CR	0x07	/* Peripheral Bank 7 Config Reg */
>> +#define DCRN_EBC_PB0AP	0x10	/* Peripheral Bank 0 Access Parameters */
>> +#define DCRN_EBC_PB1AP	0x11	/* Peripheral Bank 1 Access parameters */
>> +#define DCRN_EBC_PB2AP	0x12	/* Peripheral Bank 2 Access Parameters */
>> +#define DCRN_EBC_PB3AP	0x13	/* Peripheral Bank 3 Access Parameters */
>> +#define DCRN_EBC_PB4AP	0x14	/* Peripheral Bank 4 Access Parameters */
>> +#define DCRN_EBC_PB5AP	0x15	/* Peripheral Bank 5 Access Parameters */
>> +#define DCRN_EBC_PB6AP	0x16	/* Peripheral Bank 6 Access Parameters */
>> +#define DCRN_EBC_PB7AP	0x17	/* Peripheral Bank 7 Access Parameters */
>> +#define DCRN_EBC_PBEAR	0x20	/* Peripheral Bus Error Address Reg */
>> +#define DCRN_EBC_PBESR0	0x21	/* Peripheral Bus Error Status Reg 0 */
>> +#define DCRN_EBC_PBESR1	0x22	/* Peripheral Bus Error Status Reg 1 */
>> +#define DCRN_EBC_EPCR	0x23	/* External Peripheral Control Reg */
>>   #endif
>>
>>   #ifdef DCRN_EXIER_BASE
>> @@ -286,6 +306,13 @@
>>   #ifdef DCRN_SDRAM0_BASE
>>   #define DCRN_SDRAM0_CFGADDR	(DCRN_SDRAM0_BASE + 0x0)	/* Memory 
>> Controller Address */
>>   #define DCRN_SDRAM0_CFGDATA	(DCRN_SDRAM0_BASE + 0x1)	/* Memory 
>> Controller Data */
>> +#define DCRN_SDRAM0_CFG		0x20	/* SDRAM Configuration */
>> +#define DCRN_SDRAM0_STATUS	0x24	/* SDRAM Controller Status */
>> +#define DCRN_SDRAM0_RTR		0x30	/* Refresh Timer Reg */
>> +#define DCRN_SDRAM0_PMIT	0x34	/* Power Management Idle Timer */
>> +#define DCRN_SDRAM0_B0CR	0x40	/* Memory Bank 0 Configuration Reg */
>> +#define DCRN_SDRAM0_B1CR	0x44	/* Memory Bank 1 Configuration Reg */
>> +#define DCRN_SDRAM0_TR		0x80	/* SDRAM Timing Reg */
>>   #endif
>>
>>   #ifdef DCRN_OCM0_BASE
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 
