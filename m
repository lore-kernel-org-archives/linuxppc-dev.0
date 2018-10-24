Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00D3C004D3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 15:14:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F6B207DD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 15:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F6B207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gDLj6x1bzDrL3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 02:14:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gDJd5DZRzDrCQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 02:12:33 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42gDJY1sRWz9ttSc;
 Wed, 24 Oct 2018 17:12:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id APSI7voBtaHP; Wed, 24 Oct 2018 17:12:29 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42gDJY139Lz9ttBT;
 Wed, 24 Oct 2018 17:12:29 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id 7933F816; Wed, 24 Oct 2018 17:12:28 +0200 (CEST)
Received: from 37.170.171.166 ([37.170.171.166]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Wed, 24 Oct 2018 17:12:28 +0200
Date: Wed, 24 Oct 2018 17:12:28 +0200
Message-ID: <20181024171228.Horde.g2r8Qp5NqN_pn0TW6sUFCw6@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH 3/9] powerpc/mm: Remove extern from function definition
References: <1540220060-30162-1-git-send-email-leitao@debian.org>
 <1540220060-30162-3-git-send-email-leitao@debian.org>
 <20181023173828.Horde.uVbl4TiimFw-HLaYHTWqNw9@messagerie.si.c-s.fr>
 <3bd3ed6e-3390-a80f-59f8-c1cc0efaa10f@debian.org>
In-Reply-To: <3bd3ed6e-3390-a80f-59f8-c1cc0efaa10f@debian.org>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
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

Breno Leitao <leitao@debian.org> a =C3=A9crit=C2=A0:

> hi Christophe,
>
> On 10/23/2018 12:38 PM, LEROY Christophe wrote:
>> Breno Leitao <leitao@debian.org> a =C3=A9crit :
>>>
>>> This patch removes the keyword from the definition part, while keeps
>>> it in
>>> the declaration part.
>>
>> I think checkpatch also says that extern should be avoided in declaratio=
ns.
>
> Thanks for the review. I tried to look at this complain, but I didn't see
> this behavior on checkpatch.pl from kernel 4.19. I created a commit that =
adds
> a new extern prototype and checked the patch. Take a look:

Use option --strict with checkpatch.pl

Christophe

>
> # git show
>
> 	commit 720cd4ee7bf3c0607eaea79e209b719bac79508e
> 	Author: Breno Leitao <leitao@debian.org>
> 	Date:   Wed Oct 24 10:31:54 2018 -0400
>
> 	powerpc/mm: New test function
>
> 	New test function.
>
> 	Signed-off-by: Breno Leitao <leitao@debian.org>
>
> 	diff --git a/arch/powerpc/include/asm/hugetlb.h
> 	b/arch/powerpc/include/asm/hugetlb.h
> 	index 2d00cc530083..4a348e42cab6 100644
> 	--- a/arch/powerpc/include/asm/hugetlb.h
> 	+++ b/arch/powerpc/include/asm/hugetlb.h
> 	@@ -167,6 +167,8 @@ extern int huge_ptep_set_access_flags(struct=20=20
>=20vm_area_struct *vma,
> 				      unsigned long addr, pte_t *ptep,
> 				      pte_t pte, int dirty);
>
> 	+extern int test(int foo);
> 	+
> 	static inline pte_t huge_ptep_get(pte_t *ptep)
> 	{
> 		return *ptep;
>
> 	diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> 	index 5c390f5a5207..2e8f5f77f7f6 100644
> 	--- a/mm/hugetlb.c
> 	+++ b/mm/hugetlb.c
> 	@@ -3204,6 +3204,11 @@ static void set_huge_ptep_writable(struct
> 	vm_area_struct *vma,
> 		update_mmu_cache(vma, address, ptep);
> 	}
>
> 	+int test(int foo)
> 	+{
> 	+	return foo;
> 	+}
> 	+
> 	bool is_hugetlb_entry_migration(pte_t pte)
> 	{
> 	swp_entry_t swp;
>
>
> # scripts/checkpatch.pl -g HEAD
>
> 	total: 0 errors, 0 warnings, 19 lines checked
>
> 	Commit 720cd4ee7bf3 ("powerpc/mm: New test function") has no obvious
> 	style problems and is ready for submission.


