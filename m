Date: Sat, 24 Jul 2004 11:52:35 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Andreas Oberritter <obi@saftware.de>
Cc: Matt Porter <mporter@kernel.crashing.org>,
	Dan Malek <dan@embeddededge.com>,
	Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] export m8xx_cpm_hostalloc
Message-ID: <20040724115234.A32427@home.com>
References: <1090590567.3939.20.camel@localhost.localdomain> <20040723140231.GA21814@smtp.west.cox.net> <6658EF7A-DCB6-11D8-BC2F-003065F9B7DC@embeddededge.com> <20040723083856.A25212@home.com> <1090674246.3023.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1090674246.3023.1.camel@localhost.localdomain>; from obi@saftware.de on Sat, Jul 24, 2004 at 03:04:06PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Jul 24, 2004 at 03:04:06PM +0200, Andreas Oberritter wrote:
> Am Fr, den 23.07.2004 schrieb Matt Porter um 17:38:
> > That doesn't exist in 2.6. Use dma_alloc_coherent().
>
> Thanks, that works, but requires the attached patch. Please apply.

Ack. I forgot to submit this one before I left on vacation, it
was languishing in one of my working trees. Submitted.

Thanks,
Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
