Message-ID: <3DE4C207.8020500@iram.es>
Date: Wed, 27 Nov 2002 14:00:55 +0100
From: Gabriel Paubert <paubert@iram.es>
MIME-Version: 1.0
To: wilhardt@synergymicro.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC7455 and lwarx
References: <3DE3EF0B.F3204162@synergymicro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dave Wilhardt wrote:
> Hello,
>
> Is anyone using the MPC745x series and performing lwarx/stwcx. in non
> cached
> space?  The 7410 didn't seem to care but the MPC7455 take a DSI
> exception
> on non cached regions.  Is there a work-around?

No, it is documented somewhere in Motorola docs that lwarx/stwcx. only
work on writeback cacheable space. Earlier processors allow non-cacheable
space, I believe that this restriction was introduced with the 7440/7450.

	Regards,
	Gabriel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
