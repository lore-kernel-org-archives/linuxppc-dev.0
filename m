From: "Dale Farnsworth" <Dale.Farnsworth@mvista.com>
Date: Thu, 21 Nov 2002 15:12:41 -0700
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: __copy_tofrom_user fails on unaligned read faults
Message-ID: <20021121221241.GE6090@cuzco.az.mvista.com>
References: <20021121215050.GD6090@cuzco.az.mvista.com> <3DDD5924.3030506@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DDD5924.3030506@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 21, 2002 at 05:07:32PM -0500, Dan Malek wrote:
> Dale Farnsworth wrote:
>
> >For performance reasons, __copy_tofrom_user copies
> >data in 16-bytes chunks.  If a read fault occurs in the
> >middle of one of these chunks,
>
> How do you get a read fault in the middle of a 16-byte
> aligned data copy?

The 16-byte copy is aligned on the destination address.
It is unaligned with respect to the source address.

-Dale

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
