Date: Tue, 12 Dec 2000 13:36:59 +1100
From: Graham Stoney <greyham@research.canon.com.au>
To: Brian Ford <ford@vss.fsi.com>
Cc: Graham Stoney <greyham@research.canon.com.au>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.5 or 2.4 kernel profiling
Message-ID: <20001212133658.C1773@brixi.research.canon.com.au>
References: <20001211114533.A2691@brixi.research.canon.com.au> <Pine.GSO.4.21.0012110920300.24199-100000@eos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.21.0012110920300.24199-100000@eos>; from ford@vss.fsi.com on Mon, Dec 11, 2000 at 09:27:18AM -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Dec 11, 2000 at 09:27:18AM -0600, Brian Ford wrote:
> I agree with you about the profiling stuff.  Did you post this idea to the
> main kernel mailing list?

Sure; they were all too busy though.  Profiling already worked for most of
them, and a cross-architecture change either requires the co-operation of all
seperate architecture maintainers, or a dictatorial initiative from above.

> Thanks.  I had already hacked something like this together.  It would be
> great to finalize these and get them into the real sources.

Yes, that would be excellent.

> I also turned checksumming off for testing purposes.  It helped some, but
> I think my bottle neck is that I can't get the bus to run faster than 33
> Mhz reliably.  If I could get the bus clocked at what it is rated, I might
> be better off.

Absolutely; the bus is the bottleneck.  You'll find the network throughput
scales almost linearly with bus speed, so getting it clocked faster will give
a higher payback than more driver tweaking.  Also, doesn't the 8260 have
seperate memory subsystems to help get around this?

Regards,
Graham
--
Graham Stoney
Assistant Technology Manager
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
