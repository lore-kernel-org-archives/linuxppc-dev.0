Return-Path: <hmh@hmh.eng.br>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DBF9C1A1B46
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 20:37:17 +1000 (AEST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id 1BAD521546
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 06:37:14 -0400 (EDT)
Message-Id: <1433327833.2629421.285594817.4B21A0BD@webmail.messagingengine.com>
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Darren Hart <dvhart@infradead.org>
Cc: Finn Thain <fthain@telegraphics.com.au>, linux-kernel@vger.kernel.org,
 linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <20150603033401.GB49670@vmdeb7>
References: <20150531010132.289674310@telegraphics.com.au>
 <20150531010134.129479218@telegraphics.com.au>
 <20150531041114.GA30431@khazad-dum.debian.net>
 <alpine.LNX.2.00.1505311605420.23528@nippy.intranet>
 <20150531143422.GA12337@khazad-dum.debian.net>
 <1433239768.902135.284523153.1200C3E3@webmail.messagingengine.com>
 <20150603033401.GB49670@vmdeb7>
Subject: Re: [RFC 07/24] x86/thinkpad_acpi: Use arch_nvram_ops methods instead
 of nvram_read_byte() and nvram_write_byte()
Date: Wed, 03 Jun 2015 07:37:13 -0300
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 3, 2015, at 00:34, Darren Hart wrote:
> On Tue, Jun 02, 2015 at 07:09:28AM -0300, Henrique de Moraes Holschuh
> wrote:
> > Test results were sent to me privately, and they are correct, so...
> 
> Finn, unless there is some compelling reason not to - like they are MBs
> worth of
> data, please submit these to the list in the future so we have them for
> reference.

After I told him which exact bitmask to use on a T43 to test
hotkey_source_mask, his test results can be summarized as "I could see
no difference in behavior", which is *exactly* what I expected to
happen.

If anything went wrong with the thinkpad-acpi NVRAM code, you'd notice a
very large change in behavior (typical: hotkeys don't work, less
typical: random hotkey keypresses, hotkey press bursts, low responsivity
of hotkeys).

> > Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> 
> I'm fine with the changes, but they need to be submitted with the other
> changes
> as this one change cannot compile independently in my tree.
> 
> Finn, please work with whomever is pulling the series to include this in
> their
> pull request.
> 
> Reviewed-by: Darren Hart <dvhart@linux.intel.com>

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
