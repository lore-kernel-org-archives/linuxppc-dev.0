Date: Wed, 19 Nov 2003 09:13:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Guy M. Streeter" <streeter@redhat.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: add 8280 processor support
Message-ID: <20031119161305.GC935@ip68-0-152-218.tc.ph.cox.net>
References: <1069168993.1045.7.camel@jarjar.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1069168993.1045.7.camel@jarjar.hsv.redhat.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Nov 18, 2003 at 09:23:13AM -0600, Guy M. Streeter wrote:

> As far as I can tell, all that's necessary to add support for the 8280
> processor is to include it in the cpu_specs table.
> I'm running on an 8280 board with the attached patch, which I would like
> to see included in the kernel source.

I've commited this to my 2.4.24-pre tree and put it in my dir of patches
for akpm once he takes over.  Thanks.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
