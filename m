Return-Path: <w@1wt.eu>
Received: from 1wt.eu (1wt.eu [62.212.114.60])
 by ozlabs.org (Postfix) with ESMTP id 400F2B709D
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Feb 2012 17:43:06 +1100 (EST)
Date: Tue, 14 Feb 2012 07:42:50 +0100
From: Willy Tarreau <w@1wt.eu>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH stable-2.6.27] powerpc: Add more Power7 specific
 definitions
Message-ID: <20120214064250.GC5221@1wt.eu>
References: <8849.1329094322@neuling.org> <20120213063528.GU21225@1wt.eu>
 <20120213224418.GA22646@thor.bakeyournoodle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120213224418.GA22646@thor.bakeyournoodle.com>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
 stable@kernel.org, Eric B Munson <emunson@mgebm.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Tony,

On Tue, Feb 14, 2012 at 09:44:19AM +1100, Tony Breeds wrote:
> On Mon, Feb 13, 2012 at 07:35:28AM +0100, Willy Tarreau wrote:
> > On Mon, Feb 13, 2012 at 11:52:02AM +1100, Michael Neuling wrote:
> > > stable-2.6.27.60 added c24cb8e5 which uses PV_POWER7 but it's not
> > > defined.  Following patch adds these definitions.
> > 
> > Thank you for the report Michael, I have no PPC toolchain so I have
> > not tested this one. Added now.
> 
> Just pimping the cross toolchains I build:
> 	http://kernel.org/pub/tools/crosstool/files/bin/

Thanks for this pointer, it can indeed be quite useful from time to time,
especially to check gcc-related regressions.

That said, I'd rather not install a number of toolchains for systems
I can't test. I regularly build for i386/x86_64/arm with real configs
that I can boot a machine on when I have a doubt. Building random
configs do not always test all source code, especially on architectures
which support a wide variety of embedded platforms.

But I'm keeping the URL, Thanks :-)
Willy
