To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] ethtool support to 8260 fcc ethernet driver (and other stuff) 
In-reply-to: Your message of "Mon, 11 Nov 2002 07:49:57 -0700"
             <20021111144957.GB602@opus.bloom.county>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 12 Nov 2002 10:12:32 +1100
Message-ID: <26563.1037056352@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 11 Nov 2002 07:49:57 -0700, Tom Rini <trini@kernel.crashing.org> writes:
>Could you please split this up into 9 logical patches then?

Hi Tom, I knew you would say this :-) But I don't have a lot of spare time at
the moment, just enough to put this patch together and get it out in case it
would help others. To produce this patch was fairly trivial - just a simple
diff, but to split it up would take a fair amount of effort (since there
would be a number of places where the various bits clashed). I will do it
eventually, but don't hold your breath. Perhaps there is someone out there
with more time? (yeah right :-)

>That part should also just be:
>obj-$(CONFIG_FCC_GENERIC_MII) += mii.o

OK, thanks. Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing & Infra. Tech.      Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
