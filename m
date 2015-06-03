Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 8A5221A005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 17:38:19 +1000 (AEST)
Date: Wed, 3 Jun 2015 17:38:05 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Darren Hart <dvhart@infradead.org>
cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org,
 linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
Subject: Re: [RFC 07/24] x86/thinkpad_acpi: Use arch_nvram_ops methods instead
 of nvram_read_byte() and nvram_write_byte()
In-Reply-To: <20150603033401.GB49670@vmdeb7>
Message-ID: <alpine.LNX.2.00.1506031722530.15426@nippy.intranet>
References: <20150531010132.289674310@telegraphics.com.au>
 <20150531010134.129479218@telegraphics.com.au>
 <20150531041114.GA30431@khazad-dum.debian.net>
 <alpine.LNX.2.00.1505311605420.23528@nippy.intranet>
 <20150531143422.GA12337@khazad-dum.debian.net>
 <1433239768.902135.284523153.1200C3E3@webmail.messagingengine.com>
 <20150603033401.GB49670@vmdeb7>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Tue, 2 Jun 2015, Darren Hart wrote:

> On Tue, Jun 02, 2015 at 07:09:28AM -0300, Henrique de Moraes Holschuh 
> wrote:
> > Test results were sent to me privately, and they are correct, so...
> > 
> 
> Finn, unless there is some compelling reason not to - like they are MBs 
> worth of data, please submit these to the list in the future so we have 
> them for reference.

Sure. Those results were just confirmation that this patch series doesn't 
affect input events read directly from 
/dev/input/by-path/platform-thinkpad_acpi-event
given the the hotkey_source_mask settings discussed in this thread.

> 
> > Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> 
> I'm fine with the changes, but they need to be submitted with the other 
> changes as this one change cannot compile independently in my tree.
> 
> Finn, please work with whomever is pulling the series to include this in 
> their pull request.

Right.

> 
> Reviewed-by: Darren Hart <dvhart@linux.intel.com>

Thanks for your review.

-- 
