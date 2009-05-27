Return-Path: <pku.leo@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 71AA6DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 18:24:29 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so2045498ywt.39
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 01:24:27 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <e9c3a7c20905261659v5d785df3w646efd4cbba2e6dd@mail.gmail.com>
References: <2a27d3730905220347s59dbd152kc69c8399693ae307@mail.gmail.com>
	<e9c3a7c20905261659v5d785df3w646efd4cbba2e6dd@mail.gmail.com>
Date: Wed, 27 May 2009 16:24:26 +0800
Message-ID: <2a27d3730905270124q235cb2b9n1d079cf66a541028@mail.gmail.com>
Subject: Re: [GIT PULL] fsldma driver fixes
From: Li Yang <leoli@freescale.com>
To: Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	lkml <linux-kernel@vger.kernel.org>, Ira Snyder <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 27, 2009 at 7:59 AM, Dan Williams <dan.j.williams@intel.com> wr=
ote:
> On Fri, May 22, 2009 at 3:47 AM, Li Yang <leoli@freescale.com> wrote:
>> Hi Dan,
>>
>> Here are fixes for Freescale DMA engine driver.
>>
>> Thanks,
>> - Leo
>>
>>
>> The following changes since commit 5805977e63a36ad56594a623f3bd2bebcb7db=
233:
>> =C2=A0Linus Torvalds (1):
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Merge branch 'for-linus' of git://git.kernel.=
org/.../jbarnes/drm-2.6
>>
>> are available in the git repository at:
>>
>> =C2=A0git://git.kernel.org/pub/scm/linux/kernel/git/leo/fsl-soc.git fsld=
ma
>>
>> Ira Snyder (4):
>> =C2=A0 =C2=A0 =C2=A0fsldma: fix "DMA halt timeout!" errors
>> =C2=A0 =C2=A0 =C2=A0fsldma: fix infinite loop on multi-descriptor DMA ch=
ain completion
>> =C2=A0 =C2=A0 =C2=A0fsldma: snooping is not enabled for last entry in de=
scriptor chain
>> =C2=A0 =C2=A0 =C2=A0fsldma: fix memory leak on error path in fsl_dma_pre=
p_memcpy()
>>
>> Li Yang (1):
>> =C2=A0 =C2=A0 =C2=A0fsldma: update mailling list address in MAINTAINERS
>>
>> Roel Kluin (1):
>> =C2=A0 =C2=A0 =C2=A0fsldma: fix check on potential fdev->chan[] overflow
>>
>
> Pulled, thanks. =C2=A0These all look like 2.6.30 candidates, right?

Yes, they are pure fixes.

- Leo
