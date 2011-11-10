Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 67A2D1007F8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 03:55:04 +1100 (EST)
Date: Thu, 10 Nov 2011 10:54:55 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC PATCH 00/17] powerpc/e500: separate e500 from e500mc
Message-ID: <20111110165455.GE11983@schlenkerla.am.freescale.net>
References: <4E42AB6F.1050900@freescale.com>
 <1320883399-15911-1-git-send-email-Kyle.D.Moffett@boeing.com>
 <FF2BF3F3-1158-4747-AEEC-03D6A7C462D9@kernel.crashing.org>
 <C0DED343-76A8-457E-BF54-E52DFCAC83A8@boeing.com>
 <58FDDDA5-26C4-493B-A00D-81DD94A5C26A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <58FDDDA5-26C4-493B-A00D-81DD94A5C26A@kernel.crashing.org>
Cc: Timur Tabi <B04825@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Moffett,
 Kyle D" <Kyle.D.Moffett@boeing.com>,
 Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 10, 2011 at 10:30:41AM -0600, Kumar Gala wrote:
> On Nov 10, 2011, at 10:17 AM, Moffett, Kyle D wrote:
> > Furthermore, it looks like there are a couple issues here I missed
> > before.  PPC64 systems all appear to have an L1_CACHE_SHIFT of 7,
> > except when you turn on the P5020DS board option which magically
> > changes it to "6" and breaks lord-knows-what.  I think my patch
> > series actually "breaks" that and makes e5500 use 7 as well.
> 
> a value of '6' on E5500 / P5020DS is correct and doesn't break anything.  Setting it to 7 is wrong and thus the code is correct today.
> 
> > Are you sure that a kernel built to support E5500 can also run on
> > other 64-bit PowerPC/POWER systems?
> 
> No it will not.  There is not expectation of that as E5500 is an
> embedded / Book-E class part and uses that ISA version.  Book-S
> (server) 64-bit machines are not OS compatible and we are not trying to
> make them as such (but we do re-use a lot of code).

What about other 64-bit book3e chips?  What cache block size does A2 have?

-Scott
