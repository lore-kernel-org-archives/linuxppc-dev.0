Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ot0-x244.google.com (mail-ot0-x244.google.com
 [IPv6:2607:f8b0:4003:c0f::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wC440qnbzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 22:01:07 +1000 (AEST)
Received: by mail-ot0-x244.google.com with SMTP id i5-v6so16627862otf.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 05:01:07 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <CA+7wUsw4Us749j8yO5zpqfMcYWPMujwkNq0CRSSWWVFDJXLS0w@mail.gmail.com>
References: <20180529210257.26da8de7@canb.auug.org.au>
 <CA+7wUsw4Us749j8yO5zpqfMcYWPMujwkNq0CRSSWWVFDJXLS0w@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 29 May 2018 14:00:45 +0200
Message-ID: <CA+7wUswm60dZAfnTYJ-2p3o1H1ubwn1_OH7GSu9Y_PRKKCHJog@mail.gmail.com>
Subject: Re: linux-next: boot messages from today's linux-next
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 29, 2018 at 1:56 PM, Mathieu Malaterre <malat@debian.org> wrote:
> On Tue, May 29, 2018 at 1:02 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> Hi all,
>>
>> My qemu boots of today's powerpc linux-next kernel produced the following
>> boot message differences:
>>
>> -Max number of cores passed to firmware: 2048 (NR_CPUS = 2048)
>> +Max number of cores passed to firmware: u (NR_CPUS = 2048)
>>
>> Seemingly caused by commit
>>
>>   eae5f709a4d7 ("powerpc: Add __printf verification to prom_printf")
>
> My bad. Patch is pending (thanks Michael!):
>
> https://patchwork.ozlabs.org/patch/921948/

Nope, nevermind this is unrelated.

>> --
>> Cheers,
>> Stephen Rothwell
