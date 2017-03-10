Return-Path: <me@tobin.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfgCr3ySHzDqXh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 19:19:36 +1100 (AEDT)
Date: Fri, 10 Mar 2017 19:19:29 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: asm: convert directive .llong to .8byte
Message-ID: <20170310081929.GA23154@eros>
References: <1489038132-3523-1-git-send-email-me@tobin.cc>
 <87o9xa3sd7.fsf@possimpible.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87o9xa3sd7.fsf@possimpible.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 10, 2017 at 11:09:08AM +1100, Daniel Axtens wrote:
> Hi Tobin,
> 
> > .llong is an undocumented PPC specific directive. The generic
> > equivalent is .quad, but even better (because it's self describing) is
> > .8byte.
> >
> > Convert directives .llong -> .8byte
> >
> > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> > ---
> >
> > Fixes: issue #33 (github)
> 
> Thanks for tackling these!
> 
> I have applied your patch to my local tree. I ran `git grep '\.llong'`,
> and found:
> 
> tools/testing/selftests/powerpc/switch_endian/switch_endian_test.S: .llong 0x5555AAAA5555AAAA
> 
> That file is also handled by mpe and the powerpc tree even though it
> doesn't live in arch/powerpc - could you please change that one as well?

Awesome, thanks Daniel. I did not know to look there. Will re submit.

thanks,
Tobin.
