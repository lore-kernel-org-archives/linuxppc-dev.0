Return-Path: <av1474@comtv.ru>
Received: from akado.ru (fe02x03-cgp.akado.ru [77.232.31.165])
 by ozlabs.org (Postfix) with ESMTP id E00FB2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Sep 2012 20:12:57 +1000 (EST)
Date: Sat, 22 Sep 2012 14:12:42 +0400 (MSK)
From: malc <av1474@comtv.ru>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Probing for native availability of isel from userspace
In-Reply-To: <50EE7AAC-3080-4B1B-B741-E3F7F5A57A73@kernel.crashing.org>
Message-ID: <alpine.LNX.2.00.1209221412010.1468@linmac>
References: <alpine.LNX.2.00.1209212355050.8539@linmac>
 <50EE7AAC-3080-4B1B-B741-E3F7F5A57A73@kernel.crashing.org>
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

On Sat, 22 Sep 2012, Segher Boessenkool wrote:

> > Is it possible to determine if _native_ isel is available from userspace
> > somehow?
> 
> Just try to execute one and catch the SIGILL?
> 

Unfortunately my kernel emulates ISEL for me in this case, so i don't
get any SIGILLs.

-- 
mailto:av1474@comtv.ru
