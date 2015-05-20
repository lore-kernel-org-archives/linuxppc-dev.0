Return-Path: <james.smart@avagotech.com>
Received: from mail-qk0-f174.google.com (mail-qk0-f174.google.com
 [209.85.220.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 28E001A060E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 23:11:41 +1000 (AEST)
Received: by qkdn188 with SMTP id n188so26195477qkd.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 06:11:39 -0700 (PDT)
Message-ID: <555C8800.6060609@avagotech.com>
Date: Wed, 20 May 2015 09:11:28 -0400
From: James Smart <james.smart@avagotech.com>
MIME-Version: 1.0
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Sebastian Herbszt <herbszt@gmx.de>,
 james.smart@emulex.com
Subject: Re: [PATCH kernel] commit 4fbdf9cb ("lpfc: Fix for lun discovery
 issue with saturn adapter.")
References: <1430209582-23925-1-git-send-email-aik@ozlabs.ru>	<5548E2C1.3070209@emulex.com>
 <20150505234659.00003ab7@localhost> <555C0595.9060507@ozlabs.ru>
In-Reply-To: <555C0595.9060507@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: linux-scsi@vger.kernel.org, "James E . J . Bottomley" <JBottomley@odin.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Not sure - I'll go look.

-- james


On 5/19/2015 11:55 PM, Alexey Kardashevskiy wrote:
> On 05/06/2015 07:46 AM, Sebastian Herbszt wrote:
>> James Smart wrote:
>>>
>>> Reviewed-By: James Smart <james.smart@emulex.com>
>>>
>>>
>>> Alexey, Sebastian,
>>>
>>> Yes - this section needs to be reverted.  This patch is good.
>>>
>>> -- james s
>>
>> Reviewed-by: Sebastian Herbszt <herbszt@gmx.de>
>
>
> Unfortunately, just this revert is not enough, it fixed one of my 
> machines but I have another machine with "Emulex Corporation Saturn-X: 
> LightPulse Fibre Channel Host Adapter (rev 03)" which does not boot - 
> the booting process stops at "[  OK  ] Reached target Basic System."
>
> Any quick idea what else to revert between 4.0 and current upstream 
> before I dig further? Thanks!
>
>
>
