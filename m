From: Benjamin Herrenschmidt <bh40@calva.net>
To: Takashi Oe <toe@unlserve.unl.edu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: rtc again...
Date: Fri, 4 Aug 2000 14:54:45 +0200
Message-Id: <20000804125445.5797@mailhost.mipsys.com>
In-Reply-To: 
 <Pine.LNX.3.96LJ1.1b7.1000803193136.650D-100000@ofey.earthlink.net>
References: 
 <Pine.LNX.3.96LJ1.1b7.1000803193136.650D-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Oh, "nowtime" is UTC + DST fix up then???  If so, that seems to be broken
>to me

AFAIK, the timezone offset in nvram includes the DST fixup.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
