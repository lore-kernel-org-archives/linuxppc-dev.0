Message-ID: <40BF87BB.4020808@246tNt.com>
Date: Thu, 03 Jun 2004 22:19:07 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: Tom Rini <trini@KERNEL.CRASHING.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: DMA support for MPC5xxx?
References: <20040603090635.B7347@home.com> <20040603164245.B24A9C109F@atlas.denx.de> <20040603113302.A24468@home.com> <20040603185053.GN15195@smtp.west.cox.net>
In-Reply-To: <20040603185053.GN15195@smtp.west.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 >>> See the thread starting at
 >>> http://lists.linuxppc.org/linuxppc-dev/200311/msg00000.html
 >>>
 >>> David even posted on this list to get feedback  from  the
 >>> community. But I haven't seen a single reply on the mailing
 >>> lists.
 >>
 >> So? Repost. I miss stuff the first time around a lot of times
 >> myself [this is not to indicate that I would necessarily comment
 >> on 5200 stuff, just an example].
 >
 >
 > And this time do it against 2.6.  Even if 2.4 wasn't necessarily
 > frozen at the time we first tried, it is now.

Actually I got some patch to support MPC5200 ( and only this one, no
mgt5100 stuff ) for 2.6
It only supports booting, serial console and i2c. Not much but could
that be put in official tree if I submit it ? Or does it need to
support  more than that to worth inclusion.
So that at least if someone tries to implement more ( I'll resume my
work on it in a few weeks ), it has a base already in official tree.

Sylvain Munaut


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
