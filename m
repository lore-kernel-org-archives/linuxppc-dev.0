Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsmbt4xtlzDqY4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 21:00:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PowerPC][next-20170324][kselftest] kernel Oops when running
 tm/tm-signal-context-chk-vsx
In-Reply-To: <1490612559.8344.15.camel@abdul.in.ibm.com>
References: <1490612559.8344.15.camel@abdul.in.ibm.com>
Date: Tue, 28 Mar 2017 21:00:25 +1100
Message-ID: <871sthbu12.fsf@concordia.ellerman.id.au>
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

Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:

> Hi,
>
> While running kernel self tests on ppc64, tm/tm-signal-context-chk-vsx
> tests fails with Oops message. 
>
> I was able to reproduce only twice out of 20 runs on next-20170324 only.
> so it is difficult to bisect the commit causing the issue.

Can you try mainline as of this commit:

605df8d674ac ("selftests/powerpc: Replace stxvx and lxvx with stxvd2x/lxvd2x")

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=605df8d674ac65e044a0bf4998b28c2f350b7f9e

cheers
