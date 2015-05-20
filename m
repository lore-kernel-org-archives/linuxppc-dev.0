Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B1DD51A036E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 13:55:10 +1000 (AEST)
Received: by pacwv17 with SMTP id wv17so51123357pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 20:55:08 -0700 (PDT)
Message-ID: <555C0595.9060507@ozlabs.ru>
Date: Wed, 20 May 2015 13:55:01 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Sebastian Herbszt <herbszt@gmx.de>, james.smart@emulex.com
Subject: Re: [PATCH kernel] commit 4fbdf9cb ("lpfc: Fix for lun discovery
 issue with saturn adapter.")
References: <1430209582-23925-1-git-send-email-aik@ozlabs.ru>	<5548E2C1.3070209@emulex.com>
 <20150505234659.00003ab7@localhost>
In-Reply-To: <20150505234659.00003ab7@localhost>
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

On 05/06/2015 07:46 AM, Sebastian Herbszt wrote:
> James Smart wrote:
>>
>> Reviewed-By: James Smart <james.smart@emulex.com>
>>
>>
>> Alexey, Sebastian,
>>
>> Yes - this section needs to be reverted.  This patch is good.
>>
>> -- james s
>
> Reviewed-by: Sebastian Herbszt <herbszt@gmx.de>


Unfortunately, just this revert is not enough, it fixed one of my machines 
but I have another machine with "Emulex Corporation Saturn-X: LightPulse 
Fibre Channel Host Adapter (rev 03)" which does not boot - the booting 
process stops at "[  OK  ] Reached target Basic System."

Any quick idea what else to revert between 4.0 and current upstream before 
I dig further? Thanks!



-- 
Alexey
