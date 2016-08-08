Return-Path: <sam@ravnborg.org>
Received: from asavdk4.altibox.net (asavdk4.altibox.net [109.247.116.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s74hn38H6zDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 14:50:01 +1000 (AEST)
Date: Mon, 8 Aug 2016 06:49:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH 2/5] kbuild: allow archs to select build for link dead
 code/data elimination
Message-ID: <20160808044955.GA12952@ravnborg.org>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <1470399123-8455-3-git-send-email-npiggin@gmail.com>
 <20160806201423.GB25821@ravnborg.org>
 <20160808132903.0e37c967@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160808132903.0e37c967@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 08, 2016 at 01:29:03PM +1000, Nicholas Piggin wrote:
> On Sat, 6 Aug 2016 22:14:23 +0200
> Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > On Fri, Aug 05, 2016 at 10:12:00PM +1000, Nicholas Piggin wrote:
> > > Introduce LINKER_DCE option for architectures to select if they want
> > > to build with -ffunction-sections, -fdata-sections, and link with
> > > --gc-sections.  
> > 
> > Can you please try to come up with a less cryptic name.
> > "DCE" may make sense for you today.
> > Bot the naive reader will benefit from the longer and
> > more explcit form.
> 
> Yes that's a good idea. The name sucks.
> 
> We don't seem to consistently have a prefix for build configuration
> options, but we could start? KBUILD_LD_DEAD_CODE_DATA_ELIMINATION?

For cc related options we sort of have: KCONFIG_CC IIRC.
So for LD related options we could use the shorter CONFIG_LD_ prefix.

	Sam
