From: Benjamin Herrenschmidt <bh40@calva.net>
To: "Timothy A. Seufert" <tas@mindspring.com>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Stealth port problems
Date: Wed, 2 Aug 2000 18:22:29 +0200
Message-Id: <20000802162229.12340@mailhost.mipsys.com>
In-Reply-To: <v04220801b5ac55fa19ba@[10.0.0.42]>
References: <v04220801b5ac55fa19ba@[10.0.0.42]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>So it looks like it's not getting enabled on New World machines.
>After a brief look at the driver init code my impression (quite
>possibly a wildly inaccurate one BTW) is that the driver wants DMA
>channels and/or IRQs already partially configured.  On New World
>machines booted via yaboot these may not be configured by OF.  On Old
>World machines booted via BootX MacOS does the initialization.

Can you all test with my rsync tree ? I changed the test against the
number of addresses as Takashi pointed out. If it still doesn't work, we
may have to add missing addresses "manually" (I hate OF tree fixup code ;)

ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
