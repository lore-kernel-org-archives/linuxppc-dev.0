Message-ID: <3BA1A87A.63F07742@india.infogain.com>
Date: Fri, 14 Sep 2001 12:19:30 +0530
From: ashish anand <ashisha@india.infogain.com>
MIME-Version: 1.0
To: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: "Kernel logical address"  vs "Physical"
References: <6B546A602AD2D211BFF00008C7A42889041D6BE4@hrtades2.atea.be>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Goddeeris Frederic wrote:
>
> So the key is that by address is above ioremap_base. That I initially got
> away with not using ioremap is a coincidence? Right?
>
> Where could I find a complete discussion of how all this is organized? The
> documents I find are or very vague, or explain a small issue and suppose you
> have already solid knowledge about it.

ioremap_base is not unique for every board.
but 0xfaxxxxxx is above ioremap_base for most of situations.
you have to go for high level browsing of memory initialisation codes
in your source tree and do web surfing.
i don't have any idea if it is orgainsed comprehensively in one place.
you serach in your source tree where the address range containing 0xf4axxxxxxhas been
ioremapped.

on some plateform like SPARC there is "vitual io" there you might not need to ioremap
sort of interface for the address range in that "virtual io window" as there is a entry built already for  virtual --> physical ...anybody should correct me if i am wrong here..

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
