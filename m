MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Bitkeeper trouble
Date: Tue, 28 May 2002 17:37:34 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E106401281402@cceexc18.americas.cpqcorp.net>
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> On Tue, May 28, 2002 at 04:56:39PM -0500, Stephen Cameron wrote:
> >
> > "bk pull" used to work, (1 week ago) but
> > now fails for me.
[...]
> What does 'bk parent' say?  If it's not
> bk://ppc.bkbits.net/linuxppc_2_4_devel, try doing:
> bk parent bk://ppc.bkbits.net/linuxppc_2_4_devel
> and then pulling again.  I'm not sure why, but
> ppc.bkserver.net seems to
> be gone.

  bk parent http://ppc.bkbits.net/linuxppc_2_4_devel
  bk pull

works great.  Thanks! -- steve

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
