Message-ID: <3C87D809.2050206@embeddededge.com>
Date: Thu, 07 Mar 2002 16:13:45 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "Ruhland, Paul" <PRuhland@microwavedata.com>
Cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Ethernet, kernel bug/weakness
References: <A60FFE6CA339C742BE11C311EA8BFF5401637E@mdsms2.inside.mdsroc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ruhland, Paul wrote:

> Effect:
> --
> Once the ethernet traffic goes above the critical point described above, all
> cpu cycles are spent servicing the ethernet traffic.

Then something is wrong with your hardware implementation or processor
initialization.  A 50 MHz 850 will easily process the 10 Mbit Ethernet and
IP stack with cycles to spare.  Ensure you have the caches enabled and all
pipeline debug modes disabled.  There could also be something wrong with
your PHY connection, generating lots of noise/errors that requires IP
retransmission, although this really shouldn't cause trouble.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
