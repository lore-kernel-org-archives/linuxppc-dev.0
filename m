Date: Wed, 8 Nov 2000 23:02:30 +1100
From: Chris Leishman <masklin@debian.org>
To: "D.J. Barrow" <barrow_dj@yahoo.com>
Cc: Chris Leishman <masklin@debian.org>, Rod Stewart <stewart@lab43.org>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Airport debug (was Re: airport woes?)
Message-ID: <20001108230230.A4113@nina.dev.fol>
References: <20001106153722.12662.qmail@web219.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20001106153722.12662.qmail@web219.mail.yahoo.com>; from barrow_dj@yahoo.com on Mon, Nov 06, 2000 at 07:37:22AM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 06, 2000 at 07:37:22AM -0800, D.J. Barrow wrote:
>
> Hi,
> I don't have an Airport but am familiar with
> programming linux network device drivers.
>
> This symtom sounds like a it could be a classic tbusy
> (transmit busy ) getting  stuck on in the driver in
> the network device structure.
>

Actually - I don't think this is the problem, since it only locks up the send
_for the single TCP connection_.  Other TCP connections, or new ones, work
fine.

It is interesting that I only ever get the problem when accessing distant
systems (where the link is slower and less reliable) - and then it happens
very consistantly.

Chris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
