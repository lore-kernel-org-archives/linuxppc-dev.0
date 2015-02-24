Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 398881A0D1F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 11:11:24 +1100 (AEDT)
Message-ID: <1424736683.2318.0.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Update all configs using savedefconfig
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Feb 2015 11:11:23 +1100
In-Reply-To: <CAMuHMdXXoqhwEf6P0pbJb_JkEKkK4bOGBVt8jG-gqKYBBDeHQA@mail.gmail.com>
References: <1421737558-14756-1-git-send-email-mpe@ellerman.id.au>
 <CAMuHMdXXoqhwEf6P0pbJb_JkEKkK4bOGBVt8jG-gqKYBBDeHQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-02-23 at 10:59 +0100, Geert Uytterhoeven wrote:
> Hi Michael,
> 
> On Tue, Jan 20, 2015 at 8:05 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > It looks like it's ~4 years since we updated some of these, so do a bulk
> > update.
> >
> > Verified that the before and after generated configs are exactly the
> > same.
> 
> Yep, that's guaranteed by the tool (modulo bugs).
> 
> > Which begs the question why update them? The answer is that it can be
> > confusing when the stored defconfig drifts too far from the generated
> > result.
> 
> And it becomes hard to update them, e.g. for enabling or disabling a single
> option.
> 
> Now the big question is: do they still work?
> Plainly ignoring any bugs introduced in the code, there are probably several
> "select" statements that have been removed. 4 years ago, they automatically
> selected some critical options, while now, they're no longer selected, causing
> breakage.

Yeah true. So far no one has yelled at me, so perhaps we got lucky :)

cheers
