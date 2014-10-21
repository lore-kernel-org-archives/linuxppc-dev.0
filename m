Return-Path: <kirjanov@gmail.com>
Received: from mail-ie0-x235.google.com (mail-ie0-x235.google.com
 [IPv6:2607:f8b0:4001:c03::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A21E1A002B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 15:52:29 +1100 (AEDT)
Received: by mail-ie0-f181.google.com with SMTP id y20so421187ier.26
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Oct 2014 21:52:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20141021043846.8E5D4140092@ozlabs.org>
References: <1412920428-29263-1-git-send-email-bobby.prani@gmail.com>
 <20141021043846.8E5D4140092@ozlabs.org>
Date: Tue, 21 Oct 2014 08:52:27 +0400
Message-ID: <CAHj3AVnj4Etu71egZ30a-KHYdLHjd2S4J8TY0mjHX_Q+BLvLMA@mail.gmail.com>
Subject: Re: powerpc: Wire up sys_bpf() syscall
From: Denis Kirjanov <kirjanov@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Herrmann <dh.herrmann@gmail.com>, Pranith Kumar <bobby.prani@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have a test suite under samples/bpf/


On 10/21/14, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Fri, 2014-10-10 at 05:53:45 UTC, Pranith Kumar wrote:
>> This patch wires up the new syscall sys_bpf() on powerpc.
>
> Is there a test suite we can run to verify it works?
>
> cheers
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


-- 
Regards,
Denis
