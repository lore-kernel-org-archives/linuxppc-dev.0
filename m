Return-Path: <Diana.Craciun@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0186.outbound.protection.outlook.com [207.46.163.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 89B171400A3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 18:42:43 +1000 (EST)
Message-ID: <5357794F.4010503@freescale.com>
Date: Wed, 23 Apr 2014 11:26:55 +0300
From: Diana Craciun <diana.craciun@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/fsl: Updated device trees for platforms with
 corenet version 2
References: <1397834470-12844-1-git-send-email-diana.craciun@freescale.com>
 <1397858858.1694.133.camel@snotra.buserror.net>
In-Reply-To: <1397858858.1694.133.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/19/2014 01:07 AM, Scott Wood wrote:
> On Fri, 2014-04-18 at 18:21 +0300, Diana Craciun wrote:
>> From: Diana Craciun <Diana.Craciun@freescale.com>
>>
>> Updated the device trees according to the corenet-cf
>> binding definition.
>>
>> Signed-off-by: Diana Craciun <Diana.Craciun@freescale.com>
>> ---
>>   arch/powerpc/boot/dts/b4860emu.dts          | 2 +-
>>   arch/powerpc/boot/dts/fsl/b4420si-post.dtsi | 4 ----
>>   arch/powerpc/boot/dts/fsl/b4860si-post.dtsi | 4 ----
>>   arch/powerpc/boot/dts/fsl/b4si-post.dtsi    | 2 +-
>>   arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 2 +-
>>   arch/powerpc/boot/dts/t4240emu.dts          | 2 +-
>>   6 files changed, 4 insertions(+), 12 deletions(-)
> Could you update the corenet version 1 trees as well?
>
> -Scott
>
>

Yes, sure, I have this on my to do list.

Diana
