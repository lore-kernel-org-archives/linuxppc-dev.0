Message-ID: <3C46F718.2070305@embeddededge.com>
Date: Thu, 17 Jan 2002 11:08:56 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: get_irq fix for 8260 platform
References: <29887.1011251752@msa.cmst.csiro.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Murray Jensen wrote:

> Hi All, if you have an 8260 and are wondering why the latest revisions of
> the devel kernel hang during boot, then this patch might help you.

Heh :-).  Thanks, I just fixed this yesterday, too.  It appears the 8260
has been neglected for a while, and now that I am doing something with
it again I'll have more updates as well.

I didn't do the 'end' function, but I'll include this.  I'm also thinking
about a real  priority interrupt scheme like was done for the 8xx a month
or so ago.  It's a bit more complicated here, though.

Thanks again.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
