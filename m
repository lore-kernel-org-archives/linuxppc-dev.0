Subject: Re: switching linux kernels
To: jelbert@enerdyne.com (Julia Elbert)
Date: Tue, 26 Sep 2000 11:25:53 +1100 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org ('linuxppc-embedded@lists.linuxppc.org')
In-Reply-To: <67505026E29DD311A9AA00508B7315F350A522@EXCHANGE> from "Julia Elbert" at Sep 25, 2000 05:02:58 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000926002553.246FCBF@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Julia Elbert writes:
> 		I am switching to HardHat 2.2.13 from ppc 2.2.13.

No suggestions about your HDLC problem I'm afraid, but I suggest that you
switch to the 2.2.14 kernel from HardHat-1.2 (the latest) instead.  I just
noticed a nasty bug in fs/dcache.c:dcache_init in 2.2.13, which wastes 2Mb of
RAM on the dentry cache.  Not good in an embedded system, and it's fixed in
2.2.14.

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
