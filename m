Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-f170.google.com (mail-yk0-f170.google.com
 [209.85.160.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EFA021A013C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 18:13:58 +1100 (AEDT)
Received: by mail-yk0-f170.google.com with SMTP id 10so8659507ykt.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Feb 2015 23:13:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54E0FCEF.6090701@iogearbox.net>
References: <1424023605-2416-1-git-send-email-kda@linux-powerpc.org>
 <54E0FCEF.6090701@iogearbox.net>
Date: Mon, 16 Feb 2015 11:13:56 +0400
Message-ID: <CAOJe8K380m94BL=YX6NFE1m7w3VpW8uORfttO36=r99FnoZdNg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/6] bpf: Enable BPF JIT on ppc32
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Cc: netdev@vger.kernel.org, ast@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/15/15, Daniel Borkmann <daniel@iogearbox.net> wrote:
> On 02/15/2015 07:06 PM, Denis Kirjanov wrote:
>> This patch series enables BPF JIT on ppc32. There are relatevily
>> few chnages in the code to make it work.
>>
>> All test_bpf tests passed both on 7447a and P2041-based machines.
>
> I'm just wondering, next to the feedback that has already been
> provided, would opening this up for ppc32 make it significantly
> more difficult in future to migrate from classic BPF JIT to eBPF
> JIT eventually (which is what we want long-term)? Being curious,
> is there any ongoing effort from ppc people?
>

Well, I don't see significant challenges to enable eBPF on ppc64 in the future.
I'll start working on it after I get this merged
