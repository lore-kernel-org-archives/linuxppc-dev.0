Return-Path: <daniel@iogearbox.net>
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CB2A1A078C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 07:36:29 +1100 (AEDT)
Message-ID: <54E0FCEF.6090701@iogearbox.net>
Date: Sun, 15 Feb 2015 21:09:19 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
MIME-Version: 1.0
To: Denis Kirjanov <kda@linux-powerpc.org>
Subject: Re: [PATCH net-next 0/6] bpf: Enable BPF JIT on ppc32
References: <1424023605-2416-1-git-send-email-kda@linux-powerpc.org>
In-Reply-To: <1424023605-2416-1-git-send-email-kda@linux-powerpc.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: netdev@vger.kernel.org, ast@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/15/2015 07:06 PM, Denis Kirjanov wrote:
> This patch series enables BPF JIT on ppc32. There are relatevily
> few chnages in the code to make it work.
>
> All test_bpf tests passed both on 7447a and P2041-based machines.

I'm just wondering, next to the feedback that has already been
provided, would opening this up for ppc32 make it significantly
more difficult in future to migrate from classic BPF JIT to eBPF
JIT eventually (which is what we want long-term)? Being curious,
is there any ongoing effort from ppc people?
