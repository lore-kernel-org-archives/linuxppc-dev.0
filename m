Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 163821A041B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 02:52:56 +1000 (AEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux/m68k <linux-m68k@vger.kernel.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-api\@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [RFC v2 23/24] m68k/mac: Fix PRAM accessors
References: <20150614074607.242676098@telegraphics.com.au>
 <20150614074613.054681242@telegraphics.com.au>
 <CAMuHMdWzKvWjAE3u54E4xewEDX+zJqEDEvRmO2twpeD2vmBzog@mail.gmail.com>
 <alpine.LNX.2.00.1506152213340.12762@nippy.intranet>
Date: Thu, 18 Jun 2015 18:52:44 +0200
In-Reply-To: <alpine.LNX.2.00.1506152213340.12762@nippy.intranet> (Finn
 Thain's message of "Tue, 16 Jun 2015 13:10:29 +1000 (AEST)")
Message-ID: <87a8vxarhf.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Finn Thain <fthain@telegraphics.com.au> writes:

> When I have reliable documentation I always define macros. So I agree that 
> "command" bytes like 0x34 and 0x3800 should have names but what are the 
> correct names? Are we constructing an opcode containing RTC register file 
> addresses or are we issuing read/write accesses to chip registers?

Any name will do as long as the magic constant is not duplicated.  It is
more important to document the relation between two uses than to have a
correct name (which can trivially be updated later).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
