Message-ID: <3E6632D4.2080702@embeddededge.com>
Date: Wed, 05 Mar 2003 12:24:36 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: Paul Mackerras <paulus@samba.org>,
	Dale Farnsworth <dale@farnsworth.org>,
	Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch boot/common/relocate.S to start kernel at 0x000c
References: <20030305010318.6A4D3C6E0C@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Wolfgang Denk wrote:

> BTW: _all_ this writing to kernel text is a Bad  Thing  (TM),  as  it
> makes XIP (for example running from ROM) really difficult.

Well, technically you aren't writing to kernel text space, you are
writing to low real memory locations. :-)  I've done several PowerPC XIP
from rom systems without any trouble, so I kind of fail to understand
why this would cause trouble.  I don't know what we gain from XIP,
except a little available ram space, but it people want it.....


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
