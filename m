Date: Wed, 14 Jan 2004 15:38:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: valvoline <valvoline@vrlteam.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: temp.c and cputable.c issues
Message-ID: <20040114223840.GD983@stop.crashing.org>
References: <20040114193910.GN2658@adapter.n0skillz.org> <20040114221018.GB983@stop.crashing.org> <20040114201153.GO2658@adapter.n0skillz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040114201153.GO2658@adapter.n0skillz.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 14, 2004 at 09:11:53PM +0100, valvoline wrote:
> On Wed, Jan 14, 2004 at 03:10:18PM -0700, Tom Rini wrote:
>
> > There are errata documents from Motorola that tell you not to use the
> > TAU on any 745x CPU.  The omission of this flag is intentional.
>
> what's about this documents ?, if TAU is disabled what's the right way
> to fetch thermal infos for 745x based CPUs ?, any workaround or suggested
> url to start from ?

There are no workarounds or planned fixes for this errata (it varries
slightly in number from 7450/1 to 7455 to 7457 documents I think).  All
errata can be gotten from Motorolas website.
7450:
http://e-www.motorola.com/webapp/sps/site/prod_summary.jsp?code=MPC7450_ARCHIVED
7451:
http://e-www.motorola.com/webapp/sps/site/prod_summary.jsp?code=MPC7451
7455:
http://e-www.motorola.com/webapp/sps/site/prod_summary.jsp?code=MPC7455
7457:
http://e-www.motorola.com/webapp/sps/site/prod_summary.jsp?code=MPC7457

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
