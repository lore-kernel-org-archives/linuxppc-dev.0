Date: Fri, 6 Apr 2001 09:14:39 -0400 (EDT)
From: Bill Fink <billfink@capu.net>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org, billfink@capu.net
Subject: Re: MoL (BK) was:  Re: VTs and MOL broken since 2.4.3-...
In-Reply-To: <20010406082604.E06B3DB9C8@atlas.valhalla.net>
Message-ID: <Pine.LNX.4.21.0104060905200.12361-100000@gwiz.nasa.atd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On Fri, 6 Apr 2001, Iain Sandoe wrote:
>
> >  This was fixed by getting the latest 0.9.56 version.  In
> > P.S.  The 0.9.56 version of MOL can be obtained at:
> >
> >   ftp://ftp.nada.kth.se/home/f95-sry/Public/mac-on-linux/mol-0.9.56-1.src.rpm
>
> Is the MoL BK repo dead?
> (I've been unable to pull from it for ages with either "bk pull" (just comes
> returns) or "bk opull" (says it can't find the server).  Couldn't telnet to
> it either...

I think it moved a while back.  I successfully pulled MOL with bk
just a few days ago using:

	bk clone bk://zorn.theophys.kth.se:5000 mol-bk
	make libimport

						-Bill


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
