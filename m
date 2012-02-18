Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3173CB6F99
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Feb 2012 13:20:36 +1100 (EST)
Message-ID: <1329531557.3980.16.camel@pasglop>
Subject: Re: [PATCH 1/2] powerpc/85xx: fix problem that prevents PHYS_64BIT
 from configurable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Sat, 18 Feb 2012 13:19:17 +1100
In-Reply-To: <4F3EF72C.2090305@freescale.com>
References: <1329394210-1014-1-git-send-email-leoli@freescale.com>
 <EDB74FED-002D-4F94-B134-995BFB4C0A6B@kernel.crashing.org>
 <CAOZdJXWQzxWXhU_4WmeKXx1mfTxGQx=-JZx0AkZcF7CmRrp1gQ@mail.gmail.com>
 <1329513033.3980.1.camel@pasglop> <4F3EDC35.5070904@freescale.com>
 <4F3EF72C.2090305@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Timur Tabi <b04825@freescale.com>, Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-02-17 at 18:56 -0600, Scott Wood wrote:
> Yes, or maybe make it "default y", and/or require an "I know what I'm
> doing" option to be set for it to be unset if a board otherwise wants it.
> 
> The ability to turn it off is potentially useful for any board, since
> the address map is determined by boot software which can be changed, but
> we shouldn't make it too easy to fail to select it for boards that
> normally require it.

Don't we have CONFIG_EMBEDDED to make that sort of option visible ?

Cheers,
Ben.
