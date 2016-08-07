Return-Path: <amodra@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s6R4p6SVHzDqQs
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Aug 2016 13:35:06 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id ez1so21696531pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Aug 2016 20:35:06 -0700 (PDT)
Date: Sun, 7 Aug 2016 13:04:59 +0930
From: Alan Modra <amodra@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Sam Ravnborg <sam@ravnborg.org>, Nicholas Piggin <npiggin@gmail.com>,
 linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
 Nicolas Pitre <nico@linaro.org>,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/5] kbuild: allow architectures to use thin archives
 instead of ld -r
Message-ID: <20160807033459.GT20904@bubble.grove.modra.org>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <1470399123-8455-2-git-send-email-npiggin@gmail.com>
 <20160806201045.GA25821@ravnborg.org>
 <20160807114946.41b682f3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160807114946.41b682f3@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 07, 2016 at 11:49:46AM +1000, Stephen Rothwell wrote:
> Hi Sam,
> 
> On Sat, 6 Aug 2016 22:10:45 +0200 Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Did you by any chance evalue the use of INPUT in linker files.
> > Stephen back then (again based on proposal from Alan Modra),
> > also made an implementation using INPUT.
> 
> The problem with that idea was that (at least for some versions of
> binutils in use at the time) we hit a static limit to the number of
> object files and ld just stopped at that point. :-(
> 
> > See below for an updated simple patch on top of mainline.
> 
> So, I guess it was fixed, but do we know in what version?

I think the patch was
https://sourceware.org/ml/binutils/2012-06/msg00201.html

So, you need binutils 2.23 or later.

-- 
Alan Modra
Australia Development Lab, IBM
