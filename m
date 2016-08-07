Return-Path: <nicolas.pitre@linaro.org>
Received: from mail-qt0-x236.google.com (mail-qt0-x236.google.com
 [IPv6:2607:f8b0:400d:c0d::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s6S1c3dC0zDqYk
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Aug 2016 14:17:23 +1000 (AEST)
Received: by mail-qt0-x236.google.com with SMTP id w38so191125992qtb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Aug 2016 21:17:22 -0700 (PDT)
Date: Sun, 7 Aug 2016 00:17:18 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: Sam Ravnborg <sam@ravnborg.org>, Nicholas Piggin <npiggin@gmail.com>,
 linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH 1/5] kbuild: allow architectures to use thin archives
 instead of ld -r
In-Reply-To: <20160807114946.41b682f3@canb.auug.org.au>
Message-ID: <alpine.LFD.2.20.1608070008310.17623@knanqh.ubzr>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <1470399123-8455-2-git-send-email-npiggin@gmail.com>
 <20160806201045.GA25821@ravnborg.org>
 <20160807114946.41b682f3@canb.auug.org.au>
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

On Sun, 7 Aug 2016, Stephen Rothwell wrote:

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

I played with a nearly identical patch to work around the inability to 
do LTO and 'ld -r' with mainline binutils.  However this also requires 
major changes to modpost otherwise it becomes ineffective.


Nicolas
