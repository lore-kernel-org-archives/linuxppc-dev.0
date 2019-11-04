Return-Path: <SRS0=P9+W=Y4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3873ECA9ED2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Nov 2019 02:52:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9943221744
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Nov 2019 02:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9943221744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 475y5P1pjvzF32D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Nov 2019 13:52:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=yanaijie@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 475xny5s5qzF15P
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Nov 2019 13:39:18 +1100 (AEDT)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 4F4E9C720259BFB1946B;
 Mon,  4 Nov 2019 10:39:12 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 4 Nov 2019
 10:39:00 +0800
Subject: Re: Pull request: scottwood/linux.git next
To: Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
References: <20191022232155.GA26174@home.buserror.net>
 <935d65ed-526b-2cdc-31e0-d7856e750a04@huawei.com>
 <878soy36n3.fsf@mpe.ellerman.id.au>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <315887c9-5d9d-59d4-36a1-f6daabfa7934@huawei.com>
Date: Mon, 4 Nov 2019 10:38:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <878soy36n3.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 2019/11/2 18:38, Michael Ellerman wrote:
> Jason Yan <yanaijie@huawei.com> writes:
>> Hi Michael, Can you pull this to linux-next so that we can test it on
>> linux-next for some time?
> 
> Yes I plan to, I've just been busy doing other things.
> 
> As Scott said it's in linux-next anyway.
> 

Yeah, I found it in linux-next. Thanks again.

Jason

> cheers
> 
>> On 2019/10/23 7:21, Scott Wood wrote:
>>> This contains KASLR support for book3e 32-bit.
>>>
>>> The following changes since commit 612ee81b9461475b5a5612c2e8d71559dd3c7920:
>>>
>>>     powerpc/papr_scm: Fix an off-by-one check in papr_scm_meta_{get, set} (2019-10-10 20:15:53 +1100)
>>>
>>> are available in the Git repository at:
>>>
>>>     git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next
>>>
>>> for you to fetch changes up to 9df1ef3f1376ec5d3a1b51a4546c94279bcd88ca:
>>>
>>>     powerpc/fsl_booke/32: Document KASLR implementation (2019-10-21 16:09:16 -0500)
>>>
>>> ----------------------------------------------------------------
>>> Jason Yan (12):
>>>         powerpc: unify definition of M_IF_NEEDED
>>>         powerpc: move memstart_addr and kernstart_addr to init-common.c
>>>         powerpc: introduce kernstart_virt_addr to store the kernel base
>>>         powerpc/fsl_booke/32: introduce create_kaslr_tlb_entry() helper
>>>         powerpc/fsl_booke/32: introduce reloc_kernel_entry() helper
>>>         powerpc/fsl_booke/32: implement KASLR infrastructure
>>>         powerpc/fsl_booke/32: randomize the kernel image offset
>>>         powerpc/fsl_booke/kaslr: clear the original kernel if randomized
>>>         powerpc/fsl_booke/kaslr: support nokaslr cmdline parameter
>>>         powerpc/fsl_booke/kaslr: dump out kernel offset information on panic
>>>         powerpc/fsl_booke/kaslr: export offset in VMCOREINFO ELF notes
>>>         powerpc/fsl_booke/32: Document KASLR implementation
>>>
>>>    Documentation/powerpc/kaslr-booke32.rst       |  42 +++
>>>    arch/powerpc/Kconfig                          |  11 +
>>>    arch/powerpc/include/asm/nohash/mmu-book3e.h  |  11 +-
>>>    arch/powerpc/include/asm/page.h               |   7 +
>>>    arch/powerpc/kernel/early_32.c                |   5 +-
>>>    arch/powerpc/kernel/exceptions-64e.S          |  12 +-
>>>    arch/powerpc/kernel/fsl_booke_entry_mapping.S |  25 +-
>>>    arch/powerpc/kernel/head_fsl_booke.S          |  61 +++-
>>>    arch/powerpc/kernel/machine_kexec.c           |   1 +
>>>    arch/powerpc/kernel/misc_64.S                 |   7 +-
>>>    arch/powerpc/kernel/setup-common.c            |  20 ++
>>>    arch/powerpc/mm/init-common.c                 |   7 +
>>>    arch/powerpc/mm/init_32.c                     |   5 -
>>>    arch/powerpc/mm/init_64.c                     |   5 -
>>>    arch/powerpc/mm/mmu_decl.h                    |  11 +
>>>    arch/powerpc/mm/nohash/Makefile               |   1 +
>>>    arch/powerpc/mm/nohash/fsl_booke.c            |   8 +-
>>>    arch/powerpc/mm/nohash/kaslr_booke.c          | 401 ++++++++++++++++++++++++++
>>>    18 files changed, 587 insertions(+), 53 deletions(-)
>>>    create mode 100644 Documentation/powerpc/kaslr-booke32.rst
>>>    create mode 100644 arch/powerpc/mm/nohash/kaslr_booke.c
>>>
>>>
> 
> .
> 

