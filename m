Return-Path: <av1474@comtv.ru>
Received: from akado.ru (fe02x03-cgp.akado.ru [77.232.31.165])
 by ozlabs.org (Postfix) with ESMTP id 652EC2C0081
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Sep 2012 06:17:38 +1000 (EST)
Date: Sun, 23 Sep 2012 00:17:24 +0400 (MSK)
From: malc <av1474@comtv.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Probing for native availability of isel from userspace
In-Reply-To: <1348343737.1132.74.camel@pasglop>
Message-ID: <alpine.LNX.2.00.1209230016180.6262@linmac>
References: <alpine.LNX.2.00.1209212355050.8539@linmac>
 <50EE7AAC-3080-4B1B-B741-E3F7F5A57A73@kernel.crashing.org>
 <alpine.LNX.2.00.1209221412010.1468@linmac>
 <20120922102151.GA31314@visitor2.iram.es>
 <alpine.LNX.2.00.1209221936330.3878@linmac>
 <BB86F53C-6C09-41DB-9FF3-38E3027BCC82@kernel.crashing.org>
 <1348343737.1132.74.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, hollis@penguinppc.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 23 Sep 2012, Benjamin Herrenschmidt wrote:

> On Sat, 2012-09-22 at 21:08 +0200, Segher Boessenkool wrote:
> > > Thanks for suggestion, but i'd rather not play with heuristics.
> > 
> > Have a look at /sys/kernel/debug/powerpc/emulated_instructions/ then?
> 
> Userspace should *NEVER* rely on the content of debugfs, it will change
> with time, it is not a guaranteed ABI, it's purely for people to look
> at... for debugging.

Furthermore this box simply doesn't have it built-in...

> 
> Unfortunately we don't expose ISEL support via features (maybe we
> should, this is reasonably easy to fix, except that we are running short
> on feature bits and adding a new set of bits isn't totally trivial).
> 
> At this stage I would recommend using arch 2.06 as your key/trigger and
> either add a handful of known PVR values (mfpvr is emulated) for other
> CPUs you know support it (there shouldn't be that many), or just do the
> heuristic :-(
> 

Thank you.

-- 
mailto:av1474@comtv.ru
