Message-ID: <6B546A602AD2D211BFF00008C7A42889041D6BE5@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'ashish anand'" <ashisha@india.infogain.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: "Kernel logical address"  vs "Physical"
Date: Fri, 14 Sep 2001 14:13:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks!

-----Original Message-----
From: ashish anand [mailto:ashisha@india.infogain.com]
Sent: vrijdag 14 september 2001 8:50
To: Goddeeris Frederic; linuxppc-embedded@lists.linuxppc.org
Subject: Re: "Kernel logical address" vs "Physical"


Goddeeris Frederic wrote:
>
> So the key is that by address is above ioremap_base. That I initially got
> away with not using ioremap is a coincidence? Right?
>
> Where could I find a complete discussion of how all this is organized? The
> documents I find are or very vague, or explain a small issue and suppose
you
> have already solid knowledge about it.

ioremap_base is not unique for every board.
but 0xfaxxxxxx is above ioremap_base for most of situations.
you have to go for high level browsing of memory initialisation codes
in your source tree and do web surfing.
i don't have any idea if it is orgainsed comprehensively in one place.
you serach in your source tree where the address range containing
0xf4axxxxxxhas been
ioremapped.

on some plateform like SPARC there is "vitual io" there you might not need
to ioremap
sort of interface for the address range in that "virtual io window" as there
is a entry built already for  virtual --> physical ...anybody should correct
me if i am wrong here..

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
