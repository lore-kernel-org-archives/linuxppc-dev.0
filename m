Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymxlb36SmzDrKr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 21:36:10 +1100 (AEDT)
Subject: Qoriq P5020 PowerPC board doesn't boot with the latest git version
 anymore
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <ce2c842f-df48-6763-4626-adead5606acc@xenosoft.de>
 <3e4805a4-6114-205d-653b-ea6cd7fdc057@xenosoft.de>
 <8ed2edc7-a14b-35b3-86c1-a9995f41df84@xenosoft.de>
 <d8bf23c2-1805-a9c3-566d-74c0f28e88e8@xenosoft.de>
 <ab5f9c39-e801-0c6c-15fb-c5b782ab10b7@xenosoft.de>
 <87k1yazo21.fsf@concordia.ellerman.id.au>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <0540fab0-b4c1-3328-beee-558311713c7e@xenosoft.de>
Date: Wed, 29 Nov 2017 11:35:49 +0100
MIME-Version: 1.0
In-Reply-To: <87k1yazo21.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Success! :-)

I disabled PREEMPT in the kernel config and I removed the spinlock patch 
today. After that I compiled the RC1 again. With 'CONFIG_PREEMPT=n' and 
without the spinlock patch, the RC1 boots on my Qoriq P5020 PowerPC 
board without any problems.

Many thanks for your help. :-)

Cheers,
Christian


On 28 November 2017 at 11:37AM, Michael Ellerman wrote:
> Christian Zigotzky <chzigotzky@xenosoft.de> writes:
>
>> Hi All,
>>
>> I compiled the latest git kernel today. Unfortunately my Varisys Cyrus
>> Plus board still doesn't boot with the latest git kernel.
>>
>> After that I patched the kernel source code with the spinlock patch and
>> compiled the kernel again. With the spinlock patch, the latest git
>> kernel boots without any problems.
>>
>> Please find attached the spinlock patch.
> Can you remove the patch, and then build your kernel with
> CONFIG_PREEMPT=n.
>
> cheers
>
