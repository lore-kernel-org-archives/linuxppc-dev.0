In-Reply-To: <20040723140231.GA21814@smtp.west.cox.net>
References: <1090590567.3939.20.camel@localhost.localdomain> <20040723140231.GA21814@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6658EF7A-DCB6-11D8-BC2F-003065F9B7DC@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Andreas Oberritter <obi@saftware.de>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: [PATCH] export m8xx_cpm_hostalloc
Date: Fri, 23 Jul 2004 10:41:36 -0400
To: Tom Rini <trini@kernel.crashing.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Jul 23, 2004, at 10:02 AM, Tom Rini wrote:

> Must the driver use hostalloc?  I didn't think that i2c was called so
> early that kmalloc/bootmem_alloc() (or so) couldn't be used.


Should use ...consistent_alloc()


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
