Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3B3C433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Oct 2021 11:41:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57F860ED4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Oct 2021 11:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A57F860ED4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HfRc82GmFz3c5J
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Oct 2021 22:41:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HfRbc48Xpz2xvL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Oct 2021 22:41:13 +1100 (AEDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4HfRbV2BBhz9sSg;
 Wed, 27 Oct 2021 13:41:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1CyGxDHopVgI; Wed, 27 Oct 2021 13:41:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4HfRbV1Hjrz9sRr;
 Wed, 27 Oct 2021 13:41:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 16CD68B778;
 Wed, 27 Oct 2021 13:41:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 4A3tr9kP0AiX; Wed, 27 Oct 2021 13:41:10 +0200 (CEST)
Received: from [192.168.232.182] (unknown [192.168.232.182])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 720E18B776;
 Wed, 27 Oct 2021 13:41:09 +0200 (CEST)
Message-ID: <2012df5e-62ec-06fb-9f4d-e27dde184a3f@csgroup.eu>
Date: Wed, 27 Oct 2021 13:41:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: linux-next: manual merge of the audit tree with the powerpc tree
Content-Language: fr-FR
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Moore <paul@paul-moore.com>
References: <20211026133147.35d19e00@canb.auug.org.au>
 <87k0i0awdl.fsf@mpe.ellerman.id.au>
 <CAHC9VhTj7gn3iAOYctVRKvv_Bk1iQMrmkA8FVJtYzdvBjqFmvg@mail.gmail.com>
 <87tuh2aepp.fsf@mpe.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <87tuh2aepp.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Richard Guy Briggs <rgb@redhat.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 27/10/2021 à 13:29, Michael Ellerman a écrit :
> Paul Moore <paul@paul-moore.com> writes:
>> On Tue, Oct 26, 2021 at 6:55 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>> Stephen Rothwell <sfr@canb.auug.org.au> writes:
>>>> Hi all,
>>>>
>>>> Today's linux-next merge of the audit tree got conflicts in:
>>>>
>>>>    arch/powerpc/kernel/audit.c
>>>>    arch/powerpc/kernel/compat_audit.c
>>>>
>>>> between commit:
>>>>
>>>>    566af8cda399 ("powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC")
>>>>
>>>> from the powerpc tree and commits:
>>>>
>>>>    42f355ef59a2 ("audit: replace magic audit syscall class numbers with macros")
>>>>    1c30e3af8a79 ("audit: add support for the openat2 syscall")
>>>>
>>>> from the audit tree.
>>>
>>> Thanks.
>>>
>>> I guess this is OK, unless the audit folks disagree. I could revert the
>>> powerpc commit and try it again later.
>>>
>>> If I don't hear anything I'll leave it as-is.
>>
>> Hi Michael,
>>
>> Last I recall from the powerpc/audit thread there were still some
>> issues with audit working properly in your testing, has that been
>> resolved?
> 
> No.
> 
> There's one test failure both before and after the conversion to use the
> generic code.
> 
>> If nothing else, -rc7 seems a bit late for this to hit -next for me to
>> feel comfortable about this.
> 
> OK. I'll revert the patch in my tree.
> 

But it's been in the pipe since end of August and no one reported any 
issue other issue than the pre-existing one, so what's the new issue 
that prevents us to merge it two monthes later, and how do we walk 
forward then ?

Thanks
Christophe
