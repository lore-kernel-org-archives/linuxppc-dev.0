Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 98F8A1A0035
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 15:54:46 +1100 (AEDT)
Message-ID: <1413867285.5498.2.camel@concordia>
Subject: Re: powerpc: Wire up sys_bpf() syscall
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kirjanov@gmail.com>
Date: Tue, 21 Oct 2014 15:54:45 +1100
In-Reply-To: <CAHj3AVnj4Etu71egZ30a-KHYdLHjd2S4J8TY0mjHX_Q+BLvLMA@mail.gmail.com>
References: <1412920428-29263-1-git-send-email-bobby.prani@gmail.com>
 <20141021043846.8E5D4140092@ozlabs.org>
 <CAHj3AVnj4Etu71egZ30a-KHYdLHjd2S4J8TY0mjHX_Q+BLvLMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Tue, 2014-10-21 at 08:52 +0400, Denis Kirjanov wrote:
> We have a test suite under samples/bpf/

Thanks.

I looked under tools/testing/selftests, could it move in there?

cheers
