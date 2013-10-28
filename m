Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2C2442C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 04:52:18 +1100 (EST)
Message-ID: <1382982727.3410.1.camel@snotra.buserror.net>
Subject: Re: [PATCH] [RFC] Emulate "lwsync" to run standard user land on
 e500 cores
From: Scott Wood <scottwood@freescale.com>
To: James Yang <James.Yang@freescale.com>
Date: Mon, 28 Oct 2013 12:52:07 -0500
In-Reply-To: <alpine.LRH.2.00.1310251020590.31001@ra8135-ec1.am.freescale.net>
References: <1382081880-6666-1-git-send-email-wd@denx.de>
 <39CCEB38-1D9B-4918-B8F4-148D4E90FE21@kernel.crashing.org>
 <1382523314.3926.21.camel@aoeu.buserror.net>
 <BE5B0245-4ED1-4E3F-ADB1-F6A70C8FE3E1@kernel.crashing.org>
 <1382607919.9395.56.camel@pasglop>
 <6BFC8EB0-1A75-41C3-985A-E3ED14846710@kernel.crashing.org>
 <1382697373.3926.36.camel@aoeu.buserror.net>
 <alpine.LRH.2.00.1310251020590.31001@ra8135-ec1.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-10-25 at 10:25 -0500, James Yang wrote:
> On Fri, 25 Oct 2013, Scott Wood wrote:
> 
> > Has anyone measured how much this slows things down with a typical
> > userspace?
> 
> Not a measurement of the patch in question but an older similar patch 
> on 3.0.51 (8572 running Debian 5.0.3):
> 
> $ ./test-lwsync 
> cycles per emulated lwsync = 371
> cycles per sync = 36

My point was more to find out how often a typical userspace executes
these instructions.  From Wolfgang's e-mail it seems the answer is not
very often.

-Scott
