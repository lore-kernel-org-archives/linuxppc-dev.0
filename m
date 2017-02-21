Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS8LS3vDkzDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 16:33:52 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: gpiccoli@linux.vnet.ibm.com, paulus@samba.org, npiggin@gmail.com,
 xinhui.pan@linux.vnet.ibm.com
Subject: Re: [PATCH 2/3] powerpc/xmon: drop the nobt option from xmon plus
 minor fixes
In-Reply-To: <87poicm8cw.fsf@concordia.ellerman.id.au>
References: <1487290677-7200-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1487290677-7200-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <87poicm8cw.fsf@concordia.ellerman.id.au>
Date: Tue, 21 Feb 2017 16:33:52 +1100
Message-ID: <87k28km7jz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:
> "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:
...
>
> Imagine you're debugging a machine and you drop into xmon to check
> something, then drop out again.
>
> Then you go away and leave the box, and it crashes into xmon, but xmon
> doesn't print a backtrace because you've already been in xmon. Usually
> you can just get on the console and hit 't', but sometimes the machine
> crashes so hard that xmon doesn't take input - in which case you now
> have no backtrace. :sadface:

OK I read your patch wrong, the above won't happen.

But I still don't think we need any of the auto back trace suppression.

cheers
