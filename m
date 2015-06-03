Return-Path: <dvhart@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 782C81A005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 13:34:13 +1000 (AEST)
Date: Tue, 2 Jun 2015 20:34:01 -0700
From: Darren Hart <dvhart@infradead.org>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Finn Thain <fthain@telegraphics.com.au>, linux-kernel@vger.kernel.org,
 linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
Subject: Re: [RFC 07/24] x86/thinkpad_acpi: Use arch_nvram_ops methods
 instead of nvram_read_byte() and nvram_write_byte()
Message-ID: <20150603033401.GB49670@vmdeb7>
References: <20150531010132.289674310@telegraphics.com.au>
 <20150531010134.129479218@telegraphics.com.au>
 <20150531041114.GA30431@khazad-dum.debian.net>
 <alpine.LNX.2.00.1505311605420.23528@nippy.intranet>
 <20150531143422.GA12337@khazad-dum.debian.net>
 <1433239768.902135.284523153.1200C3E3@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433239768.902135.284523153.1200C3E3@webmail.messagingengine.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 02, 2015 at 07:09:28AM -0300, Henrique de Moraes Holschuh wrote:
> Test results were sent to me privately, and they are correct, so...
> 

Finn, unless there is some compelling reason not to - like they are MBs worth of
data, please submit these to the list in the future so we have them for
reference.

> Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

I'm fine with the changes, but they need to be submitted with the other changes
as this one change cannot compile independently in my tree.

Finn, please work with whomever is pulling the series to include this in their
pull request.

Reviewed-by: Darren Hart <dvhart@linux.intel.com>

-- 
Darren Hart
Intel Open Source Technology Center
