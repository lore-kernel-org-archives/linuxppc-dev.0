Message-ID: <3DDD5DE9.4030404@embeddededge.com>
Date: Thu, 21 Nov 2002 17:27:53 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Dale Farnsworth <Dale.Farnsworth@mvista.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: __copy_tofrom_user fails on unaligned read faults
References: <20021121215050.GD6090@cuzco.az.mvista.com> <3DDD5924.3030506@embeddededge.com> <20021121221241.GE6090@cuzco.az.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dale Farnsworth wrote:

> The 16-byte copy is aligned on the destination address.
> It is unaligned with respect to the source address.

I see, so do the semantics of a copy_to/from allow this behavior?
If you still return an error, how does the caller know how many
bytes were transferred?  I always thought if you handled a SEG/BUS
fault exception the contents of the buffer were undefined.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
