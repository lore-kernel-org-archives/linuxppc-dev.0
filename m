Date: Tue, 6 Aug 2002 09:13:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: acurtis@directvinternet.com,
	David Gibson <david@gibson.dropbear.id.au>
Cc: "David M?ller (ELSOFT AG)" <d.mueller@elsoft.ch>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Problem with bk repository?
Message-ID: <20020806161339.GB714@opus.bloom.county>
References: <3D4FEA26.1070403@elsoft.ch> <NCBBIINEHIPFGJPLBEIFEEGMDKAA.acurtis@directvinternet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <NCBBIINEHIPFGJPLBEIFEEGMDKAA.acurtis@directvinternet.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 06, 2002 at 08:46:50AM -0700, acurtis@directvinternet.com wrote:
>
> >
> > david@devil:/repository/linuxppc_2_4_devel>bk parent
> > Parent repository is bk://ppc.bkbits.net/linuxppc_2_4_devel
> > david@devil:/repository/linuxppc_2_4_devel>bk pull -ll
> > ERROR-Can't get read lock on the repository.
> > pull: remote locked, trying again...
> > ERROR-Can't get read lock on the repository.
> > pull: remote locked, trying again...
> > ERROR-Can't get read lock on the repository.
> > pull: remote locked, trying again...
> > ERROR-Can't get read lock on the repository.
> > pull: remote locked, trying again...
>
> I was it for the first time today too.

Are either of you still getting this?  What seems to be happening is
that when David Gibson pushes something to the tree, it never quite
finishes and Bk ends up in a slightly wierd state.  David, are you
behind some sort of wierd network setup or anything?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
