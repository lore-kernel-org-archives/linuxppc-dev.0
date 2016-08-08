Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x236.google.com (mail-pf0-x236.google.com
 [IPv6:2607:f8b0:400e:c00::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s72vX3HCSzDqS5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 13:29:12 +1000 (AEST)
Received: by mail-pf0-x236.google.com with SMTP id h186so114260712pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Aug 2016 20:29:12 -0700 (PDT)
Date: Mon, 8 Aug 2016 13:29:03 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher
 Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH 2/5] kbuild: allow archs to select build for link dead
 code/data elimination
Message-ID: <20160808132903.0e37c967@roar.ozlabs.ibm.com>
In-Reply-To: <20160806201423.GB25821@ravnborg.org>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <1470399123-8455-3-git-send-email-npiggin@gmail.com>
 <20160806201423.GB25821@ravnborg.org>
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

On Sat, 6 Aug 2016 22:14:23 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> On Fri, Aug 05, 2016 at 10:12:00PM +1000, Nicholas Piggin wrote:
> > Introduce LINKER_DCE option for architectures to select if they want
> > to build with -ffunction-sections, -fdata-sections, and link with
> > --gc-sections.  
> 
> Can you please try to come up with a less cryptic name.
> "DCE" may make sense for you today.
> Bot the naive reader will benefit from the longer and
> more explcit form.

Yes that's a good idea. The name sucks.

We don't seem to consistently have a prefix for build configuration
options, but we could start? KBUILD_LD_DEAD_CODE_DATA_ELIMINATION?

Thanks,
Nick
