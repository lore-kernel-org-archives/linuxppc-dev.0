Date: Fri, 23 Jul 2004 07:42:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Andreas Oberritter <obi@saftware.de>
Subject: Re: [PATCH] export m8xx_cpm_hostalloc
Message-ID: <20040723144257.GE21882@smtp.west.cox.net>
References: <1090590567.3939.20.camel@localhost.localdomain> <20040723140231.GA21814@smtp.west.cox.net> <6658EF7A-DCB6-11D8-BC2F-003065F9B7DC@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6658EF7A-DCB6-11D8-BC2F-003065F9B7DC@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jul 23, 2004 at 10:41:36AM -0400, Dan Malek wrote:
>
> On Jul 23, 2004, at 10:02 AM, Tom Rini wrote:
>
> >Must the driver use hostalloc?  I didn't think that i2c was called so
> >early that kmalloc/bootmem_alloc() (or so) couldn't be used.
>
> Should use ...consistent_alloc()

Not having the full context handy (and trying to listen to rml right
now), yes, that too could be the correct answer here.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
