Return-Path: <james.smart@avagotech.com>
Received: from mail-qc0-f173.google.com (mail-qc0-f173.google.com
 [209.85.216.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F2BD1A060E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 05:52:03 +1000 (AEST)
Received: by qctt3 with SMTP id t3so28928445qct.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 12:52:00 -0700 (PDT)
Message-ID: <555CE5DD.5030901@avagotech.com>
Date: Wed, 20 May 2015 15:51:57 -0400
From: James Smart <james.smart@avagotech.com>
MIME-Version: 1.0
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Sebastian Herbszt <herbszt@gmx.de>
Subject: Re: [PATCH kernel] commit 4fbdf9cb ("lpfc: Fix for lun discovery
 issue with saturn adapter.")
References: <1430209582-23925-1-git-send-email-aik@ozlabs.ru>	<5548E2C1.3070209@emulex.com>
 <20150505234659.00003ab7@localhost> <555C0595.9060507@ozlabs.ru>
 <555C8800.6060609@avagotech.com>
In-Reply-To: <555C8800.6060609@avagotech.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: linux-scsi@vger.kernel.org, "James E . J . Bottomley" <JBottomley@odin.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 James Smart <james.smart@avagotech.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexey,

Can you send me boot messages so I can see everything the lpfc driver 
may have done ?
And you're using 10.5.0.0 verbatim ?

-- james


On 5/20/2015 9:11 AM, James Smart wrote:
> Not sure - I'll go look.
>
> -- james
>
>
> On 5/19/2015 11:55 PM, Alexey Kardashevskiy wrote:
>> On 05/06/2015 07:46 AM, Sebastian Herbszt wrote:
>>> James Smart wrote:
>>>>
>>>> Reviewed-By: James Smart <james.smart@emulex.com>
>>>>
>>>>
>>>> Alexey, Sebastian,
>>>>
>>>> Yes - this section needs to be reverted.  This patch is good.
>>>>
>>>> -- james s
>>>
>>> Reviewed-by: Sebastian Herbszt <herbszt@gmx.de>
>>
>>
>> Unfortunately, just this revert is not enough, it fixed one of my 
>> machines but I have another machine with "Emulex Corporation 
>> Saturn-X: LightPulse Fibre Channel Host Adapter (rev 03)" which does 
>> not boot - the booting process stops at "[  OK  ] Reached target 
>> Basic System."
>>
>> Any quick idea what else to revert between 4.0 and current upstream 
>> before I dig further? Thanks!
>>
>>
>>
>
