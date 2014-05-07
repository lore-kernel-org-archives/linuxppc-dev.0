Return-Path: <Diana.Craciun@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com (unknown
 [207.46.163.142]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EC2A7140213
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 16:14:32 +1000 (EST)
Message-ID: <5369CF3E.2000608@freescale.com>
Date: Wed, 7 May 2014 09:14:22 +0300
From: Diana Craciun <diana.craciun@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/fsl: Updated corenet-cf compatible string for
 corenet1-cf chips
References: <1399388176-25257-1-git-send-email-diana.craciun@freescale.com>
 <1399395448.15726.185.camel@snotra.buserror.net>
In-Reply-To: <1399395448.15726.185.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/06/2014 07:57 PM, Scott Wood wrote:
> On Tue, 2014-05-06 at 17:56 +0300, Diana Craciun wrote:
>> From: Diana Craciun <Diana.Craciun@freescale.com>
>>
>> Updated the device trees according to the corenet-cf
>> binding definition.
>>
>> Signed-off-by: Diana Craciun <Diana.Craciun@freescale.com>
>> ---
>>   arch/powerpc/boot/dts/fsl/p2041si-post.dtsi | 2 +-
>>   arch/powerpc/boot/dts/fsl/p3041si-post.dtsi | 2 +-
>>   arch/powerpc/boot/dts/fsl/p4080si-post.dtsi | 2 +-
>>   arch/powerpc/boot/dts/fsl/p5020si-post.dtsi | 2 +-
>>   4 files changed, 4 insertions(+), 4 deletions(-)
> Oops, I meant to include this in the patch I sent, but forgot to squash
> the two patches together. :-P
>
> Where's p5040?

Ups, somehow I failed to commit that file, respinning....

Diana
