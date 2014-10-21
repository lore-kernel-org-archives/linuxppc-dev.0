Return-Path: <kirjanov@gmail.com>
Received: from mail-ig0-x229.google.com (mail-ig0-x229.google.com
 [IPv6:2607:f8b0:4001:c05::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 26B3B1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 16:12:55 +1100 (AEDT)
Received: by mail-ig0-f169.google.com with SMTP id uq10so7648037igb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Oct 2014 22:12:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1413867285.5498.2.camel@concordia>
References: <1412920428-29263-1-git-send-email-bobby.prani@gmail.com>
 <20141021043846.8E5D4140092@ozlabs.org>
 <CAHj3AVnj4Etu71egZ30a-KHYdLHjd2S4J8TY0mjHX_Q+BLvLMA@mail.gmail.com>
 <1413867285.5498.2.camel@concordia>
Date: Tue, 21 Oct 2014 09:12:52 +0400
Message-ID: <CAHj3AVmJqJy+c=8_tK-307W_3POuaFHacCCe6+infOqJS75uqA@mail.gmail.com>
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

I don't see any problems with it

On 10/21/14, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Tue, 2014-10-21 at 08:52 +0400, Denis Kirjanov wrote:
>> We have a test suite under samples/bpf/
>
> Thanks.
>
> I looked under tools/testing/selftests, could it move in there?
>
> cheers
>
>
>


-- 
Regards,
Denis
