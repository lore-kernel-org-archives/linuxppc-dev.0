Date: Mon, 12 Jan 2004 12:45:41 +0100
From: Colin Leroy <colin@colino.net>
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] tas3004_tables.c off-by-one
Message-Id: <20040112124541.188d0174.colin@colino.net>
In-Reply-To: <D65308DD-42F3-11D8-8972-000A95A4DC02@kernel.crashing.org>
References: <20031220175850.416fb0ec.colin@colino.net>
	<1071962774.8935.23.camel@gaston>
	<D65308DD-42F3-11D8-8972-000A95A4DC02@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 09 Jan 2004 at 23h01, Segher Boessenkool wrote:

Hi,

> It could be these tables are taken from Darwin, but there is no need
> for that; the chip manual contains those tables, too (but for a bigger
> range of values).

By the way, this was for kernel 2.4 and dmasound. Alsa drivers in 2.6
work fine.
--
Colin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
