Message-ID: <3C214A48.4080508@embeddededge.com>
Date: Wed, 19 Dec 2001 21:17:44 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Kevin Fry <kevin@carts.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: allocating non-cacheable memory
References: <3C214290.D6D1B53A@carts.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kevin Fry wrote:

> What is the best way to allocate some non-cacheable memory for I/O use?
> Right now we are going to setup a BAT table with a non-cacheable memory

If you have a processor with BAT, why do you need non-cached memory?


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
