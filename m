Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	by ozlabs.org (Postfix) with ESMTP id D670767A71
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Mar 2005 04:40:16 +1100 (EST)
Message-ID: <422F34F9.1050607@varma-el.com>
Date: Wed, 09 Mar 2005 20:40:09 +0300
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <422EEA20.4050907@varma-el.com>
	<d32d7ad858d3660f9d7fdf33003ca4cc@freescale.com>
In-Reply-To: <d32d7ad858d3660f9d7fdf33003ca4cc@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: paulus@samba.org, linuxppc-embedded@ozlabs.org
Subject: Re: RFC/Commit: New ocp id for CANbus devs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kumar:
> Is this for 2.6?  
Oh sorry, certainly for 2.6 (Sylvain's kernel more precisely).
But since, Sylvain not maintainer of ocp_ids.h, so I send
this patch to Paul (who create it, am I right?).

> If so, 5200 needs to be moved to using the new driver 
> model and platform devices.  Take a look at support for MPC85xx or 
> marvell (mv64x60) as examples.
> 
> - kumar
Kumar, please, more cleanly, what did you want to say? If you told about
board_ocp[] in lite5200.c (platform specific). Then yes, I use it, but 
not mpc5200.c

--
Andrey

> 
> On Mar 9, 2005, at 6:20 AM, Andrey Volkov wrote:
> 
>> Hi Paul,
>>
>> Pls. commit this patch, its needed for MPC5200 Can
>>
>> Regards
>>  Andrey Volkov
>>
>> Signed-off-by: Andrey Volkov <avolkov@varma-el.com>
>>  --
>>  ChangeSet@1.2159, 2005-03-09 15:05:37+03:00, avolkov@varma-el.com
>>     ocp_ids.h:
>>       New number for onboard CANbus devs.
>>
>>
>>
>>   ocp_ids.h |    1 +
>>    1 files changed, 1 insertion(+)
>>
>>
>>
>> diff -Nru a/include/asm-ppc/ocp_ids.h b/include/asm-ppc/ocp_ids.h
>>  --- a/include/asm-ppc/ocp_ids.h 2005-03-09 15:07:51 +03:00
>>  +++ b/include/asm-ppc/ocp_ids.h 2005-03-09 15:07:51 +03:00
>>  @@ -62,6 +62,7 @@
>>    #define OCP_FUNC_RGMII                0x00D3
>>    #define OCP_FUNC_TAH          0x00D4
>>    #define OCP_FUNC_SEC2         0x00D5  /* Crypto/Security 2.0 */
>>  +#define OCP_FUNC_CAN           0x00D6  /* CAN bus device */
>>
>>   /* Network 0x0200 - 0x02FF */
>>    #define OCP_FUNC_EMAC         0x0200
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>>  Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 
> 
