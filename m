Message-ID: <3DDD5924.3030506@embeddededge.com>
Date: Thu, 21 Nov 2002 17:07:32 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Dale Farnsworth <Dale.Farnsworth@mvista.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: __copy_tofrom_user fails on unaligned read faults
References: <20021121215050.GD6090@cuzco.az.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dale Farnsworth wrote:

> For performance reasons, __copy_tofrom_user copies
> data in 16-bytes chunks.  If a read fault occurs in the
> middle of one of these chunks,


How do you get a read fault in the middle of a 16-byte
aligned data copy?


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
