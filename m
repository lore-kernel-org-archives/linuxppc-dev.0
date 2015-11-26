Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 75F6E1A1894
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 23:57:31 +1100 (AEDT)
Date: Thu, 26 Nov 2015 13:57:27 +0100
From: Torsten Duwe <duwe@lst.de>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v4 1/9] ppc64 (le): prepare for -mprofile-kernel
Message-ID: <20151126125727.GA6484@lst.de>
References: <20151125172608.9588569260@newverein.lst.de>
 <20151125172855.49E3469260@newverein.lst.de>
 <CAOJe8K2o-D61zXK-TK3iLRDNu9+qc0kmmn002dA96RF_F7_2Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOJe8K2o-D61zXK-TK3iLRDNu9+qc0kmmn002dA96RF_F7_2Yg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 26, 2015 at 01:12:12PM +0300, Denis Kirjanov wrote:
> On 11/25/15, Torsten Duwe <duwe@lst.de> wrote:
> > +			 */
> > +			return 2;
> I didn't find where you check for this return value.

That's a pure debugging convenience. The return test is for != 0,
so any non-zero value will do. I've encountered situations where
I'd really liked to know _why_ a routine failed/succeeded, visible
in the registers in the debugger.

This is no big thing, I have no strong opinion about this.

	Torsten
