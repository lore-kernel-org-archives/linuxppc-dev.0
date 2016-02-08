Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4686E1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 21:34:12 +1100 (AEDT)
Date: Mon, 8 Feb 2016 11:34:06 +0100
From: Petr Mladek <pmladek@suse.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Jessica Yu <jeyu@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v7 04/10] ppc64 ftrace_with_regs configuration variables
Message-ID: <20160208103406.GC30328@pathway.suse.cz>
References: <20160204161527.5F3AC692CD@newverein.lst.de>
 <20160204162053.C76A7692D8@newverein.lst.de>
 <20160205140517.GE3305@pathway.suse.cz>
 <20160205094803.1e0c6c91@gandalf.local.home>
 <20160205161834.GF731@pathway.suse.cz>
 <20160206103243.GB3130@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160206103243.GB3130@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat 2016-02-06 11:32:43, Torsten Duwe wrote:
> On Fri, Feb 05, 2016 at 05:18:34PM +0100, Petr Mladek wrote:
> [...]
> > more complicated. Whem I think about it, the change below does similar
> > job and looks more strightforwad:
> 
> Had I only looked closer. That's exactly how I thought it would work
> in the first place. I'd call that a fix. Full ACK from my side.

Feel free to merge this into your patch. Or do you want to do
this in a separate one, please?

Best Regards,
Petr
