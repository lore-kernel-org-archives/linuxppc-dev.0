To: benh@kernel.crashing.org
Cc: Tom Rini <trini@kernel.crashing.org>,
	"Mark A. Greer" <mgreer@mvista.com>,
	Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 20 Mar 2002 17:40:24 +0100."
             <20020320164025.31626@mailhost.mipsys.com>
Date: Wed, 20 Mar 2002 17:59:46 +0100
Message-Id: <20020320165951.43233109F3@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20020320164025.31626@mailhost.mipsys.com> you wrote:
...
> The basic idea was to have bi_recs containing bi_recs, with some
> type/value pairs. something like:
...
> In the above example, the entire BI_STRUCT is a single record
> containing other records. A BI_STRUCT contains a first u32 indicating
> the structure type and then it's sub-records.

Thanks, Ben! This really helps this discussion.

> I also want to have the bi_rec types & records be defined as 4
> ASCII chars in an u32, making things readable when you debug,
> and defining, a bit like Apple does in MacOS, that full lowercase
> letters are reserved types, while others are free for use by vendors
> to pass whatever additional infos, thus a guarantee of avoiding
> clashes between vendor added bi_rec's and future kernels.

Sounds good to me :)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Quantum particles: The dreams that stuff is made of.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
