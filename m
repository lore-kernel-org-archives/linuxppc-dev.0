Message-ID: <40605667.5010600@embeddededge.com>
Date: Tue, 23 Mar 2004 10:23:19 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Jack Liu <Jack_liu@usish.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: OpenPIC problem:OpenPIC not work at 0xFC000000 on MPC8245 platform
References: <200403230445.i2N4j7kZ030569@ms.usish.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jack Liu wrote:

>   Can anybody give me your vaulable advice?

Why do you want to change it?  The kernel assumes a MAP B configuration,
there are other memory mapping assumptions made for this to work as well.
Changing a single #define associated with memory mapping usually guarantees
nothing will work, as other configuration values are chosen to be
complimentary.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
