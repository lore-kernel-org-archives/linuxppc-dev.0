Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4xFC5vPNzDqS9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 03:07:11 +1000 (AEST)
Date: Thu, 4 Aug 2016 12:06:41 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Fengguang Wu <fengguang.wu@intel.com>,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: powerpc allyesconfig / allmodconfig linux-next next-20160729 -
 next-20160729 build failures
Message-ID: <20160804170640.GC22744@gate.crashing.org>
References: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
 <1880505.MpH3ISbtMJ@wuerfel> <20160804214713.4baa832e@roar.ozlabs.ibm.com>
 <2405930.iJXNaXEjI5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2405930.iJXNaXEjI5@wuerfel>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 04, 2016 at 06:10:57PM +0200, Arnd Bergmann wrote:
> On Thursday, August 4, 2016 9:47:13 PM CEST Nicholas Piggin wrote:
> 
> > +	__used							\
> > +	__attribute__((section("___kentry" "+" #sym ",\"a\",@note #"), used)) \
> 
> 
> I've just started testing this, but the first problem I ran into
> is that @ and # are special characters that have an architecture
> specific meaning to the assembler. On ARM, you need "%note @" instead
> of "@note #".

That comment trick (I still feel guilty about it) causes more problems
than it solves.  Please don't try to use it :-)


Segher
