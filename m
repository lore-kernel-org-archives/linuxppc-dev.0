To: Matt Porter <mporter@kernel.crashing.org>
Cc: Bret Indrelee <Bret.Indrelee@qlogic.com>,
	Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Any restrictions on DMA address boundry?
References: <Pine.LNX.4.44.0309221006580.30267-100000@spider.ancor.com>
	<20030922095952.A31727@home.com>
From: Roland Dreier <roland@topspin.com>
Date: 25 Sep 2003 10:56:24 -0700
In-Reply-To: <20030922095952.A31727@home.com>
Message-ID: <52oex8kb07.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    Matt> Roland Dreier had a patch which added a little helper for
    Matt> this stuff as well as docs.  Unfortunately, it's been
    Matt> dropped on the floor until somebody with interest and time
    Matt> in non-coherent platforms picks it
    Matt> up. http://lwn.net/Articles/2482/

As I recall, the discussion ended with people like David Miller
agreeing that 2.6 would fix this in a better way, but that my patch
was OK for 2.4.  However, unaligned DMA buffers only seem to cause
pain on non-mainstream platforms, so there was never much push to have
my patch merged in 2.4.  I've never really pushed my patch since we've
fixed all the problems with our own specific embedded PPC 4xx
platform, and no one else seems to care very much.

Best,
  Roland


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
