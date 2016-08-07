Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s6NlK1SMWzDqRs
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Aug 2016 11:49:49 +1000 (AEST)
Date: Sun, 7 Aug 2016 11:49:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org,
 linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Arnd Bergmann
 <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool
 <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH 1/5] kbuild: allow architectures to use thin archives
 instead of ld -r
Message-ID: <20160807114946.41b682f3@canb.auug.org.au>
In-Reply-To: <20160806201045.GA25821@ravnborg.org>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <1470399123-8455-2-git-send-email-npiggin@gmail.com>
 <20160806201045.GA25821@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sam,

On Sat, 6 Aug 2016 22:10:45 +0200 Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Did you by any chance evalue the use of INPUT in linker files.
> Stephen back then (again based on proposal from Alan Modra),
> also made an implementation using INPUT.

The problem with that idea was that (at least for some versions of
binutils in use at the time) we hit a static limit to the number of
object files and ld just stopped at that point. :-(

> See below for an updated simple patch on top of mainline.

So, I guess it was fixed, but do we know in what version?

-- 
Cheers,
Stephen Rothwell
