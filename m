Date: Wed, 4 Sep 2002 07:15:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Allen Curtis <acurtis@onz.com>
Cc: Brian Kuschak <bkuschak@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: bitkeeper changesets
Message-ID: <20020904141511.GK761@opus.bloom.county>
References: <20020903213014.5963.qmail@web40201.mail.yahoo.com> <NCBBIINEHIPFGJPLBEIFEEJODLAA.acurtis@onz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <NCBBIINEHIPFGJPLBEIFEEJODLAA.acurtis@onz.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Sep 03, 2002 at 10:05:30PM -0700, Allen Curtis wrote:
>
> > I'm using the BK changeset versions for tracking when
> > I export specific BK trees into my local
> > source-control system.  The last one I imported was
> > 2.4.19-final (changeset 1.1114 on 08-02-2002).  Today
> > I did a 'bk pull', and noticed that that changeset
> > revision no longer exists in BK!  And it seems the one
> > I exported previously is now named 1.1091.1.23.
> >
> > Also, it seems like older versions (earlier than
> > 29-May-2002) are no longer available in BK.
> >
> > Am I missing something here, or did the version
> > numbers really change?  And why?  Should I be using a
> > different BK server?
>
> I see the same thing. It looks like the tag changed to just v2.4.19. The BK
> revisions totally changed!

Revision numbers are not constant.  BK keys are.  'bk help key2rev'.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
