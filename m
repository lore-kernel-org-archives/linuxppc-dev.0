Date: Tue, 16 Jul 2002 08:23:26 -0700
From: Matt Porter <porter@cox.net>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: consistent_alloc() revisited
Message-ID: <20020716082326.A3654@home.com>
References: <20020716021313.GQ22786@zax> <3D3428FF.5090401@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D3428FF.5090401@embeddededge.com>; from dan@embeddededge.com on Tue, Jul 16, 2002 at 10:09:03AM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jul 16, 2002 at 10:09:03AM -0400, Dan Malek wrote:
>
> David Gibson wrote:
> > 	c. be able to use highmem pages
>
> You think there will be non-coherent processors with this much memory? :-)

I guess you're kidding, but to be clear to everybody, the 440GP does
handle up to 2GB of DDR.  I run my ref platform with 1GB using highmem.

To be fair, I don't like this proliferation of non-coherent processors
(especially in the high-end PPC application space) any better than you
do. :-/

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
