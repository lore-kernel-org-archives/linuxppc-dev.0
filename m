Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5BDC46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 15:40:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6B5B20671
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 15:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B5B20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42fczH4H2pzDrdf
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 02:40:27 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42fcxC5qKtzF1Pl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 02:38:39 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42fcx42k8Dz9ttBm;
 Tue, 23 Oct 2018 17:38:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id hOrhnQI2S093; Tue, 23 Oct 2018 17:38:32 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42fcx42DWxz9ttBV;
 Tue, 23 Oct 2018 17:38:32 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id 07947A48; Tue, 23 Oct 2018 17:38:29 +0200 (CEST)
Received: from 37.173.204.157 ([37.173.204.157]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Tue, 23 Oct 2018 17:38:28 +0200
Date: Tue, 23 Oct 2018 17:38:28 +0200
Message-ID: <20181023173828.Horde.uVbl4TiimFw-HLaYHTWqNw9@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH 3/9] powerpc/mm: Remove extern from function definition
References: <1540220060-30162-1-git-send-email-leitao@debian.org>
 <1540220060-30162-3-git-send-email-leitao@debian.org>
In-Reply-To: <1540220060-30162-3-git-send-email-leitao@debian.org>
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

> Function huge_ptep_set_access_flags() has the 'extern' keyword in the
> function definition and also in the function declaration. This causes a
> warning in 'sparse' since the 'extern' storage class should be used only =
on
> symbol declarations.
>
> 	arch/powerpc/mm/pgtable.c:232:12: warning: function=20=20
>=20'huge_ptep_set_access_flags' with external linkage has definition
>
> This patch removes the keyword from the definition part, while keeps it i=
n
> the declaration part.

I think checkpatch also says that extern should be avoided in declarations.
Can you remove both ?

Christophe

>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/powerpc/mm/pgtable.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index d71c7777669c..213933b78077 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -229,7 +229,7 @@ int ptep_set_access_flags(struct vm_area_struct=20=20
>=20*vma, unsigned long address,
>  }
>
>  #ifdef CONFIG_HUGETLB_PAGE
> -extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
> +int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  				      unsigned long addr, pte_t *ptep,
>  				      pte_t pte, int dirty)
>  {
> --
> 2.19.0


