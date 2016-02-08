Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F0BB1A0190
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 23:12:50 +1100 (AEDT)
Date: Mon, 8 Feb 2016 13:12:45 +0100
From: Torsten Duwe <duwe@lst.de>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Jessica Yu <jeyu@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v7 04/10] ppc64 ftrace_with_regs configuration variables
Message-ID: <20160208121245.GA921@lst.de>
References: <20160204161527.5F3AC692CD@newverein.lst.de>
 <20160204162053.C76A7692D8@newverein.lst.de>
 <20160205140517.GE3305@pathway.suse.cz>
 <20160205094803.1e0c6c91@gandalf.local.home>
 <20160205161834.GF731@pathway.suse.cz> <20160206103243.GB3130@lst.de>
 <20160208103406.GC30328@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160208103406.GC30328@pathway.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 08, 2016 at 11:34:06AM +0100, Petr Mladek wrote:
> On Sat 2016-02-06 11:32:43, Torsten Duwe wrote:
> > On Fri, Feb 05, 2016 at 05:18:34PM +0100, Petr Mladek wrote:
> > [...]
> > > more complicated. Whem I think about it, the change below does similar
> > > job and looks more strightforwad:
> > 
> > Had I only looked closer. That's exactly how I thought it would work
> > in the first place. I'd call that a fix. Full ACK from my side.
> 
> Feel free to merge this into your patch. Or do you want to do
> this in a separate one, please?

My Kconfig/Makefile changes depend on it, but OTOH this change (Fix!)
is independent.

IMHO the right thing would be you resend your second mail from Feb-05,
with your sign-off, my ack, FWIW, and Steven checks it in ;-)

	Torsten
