Date: Wed, 4 Sep 2002 16:43:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Brian Kuschak <bkuschak@yahoo.com>
Cc: Allen Curtis <acurtis@onz.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: bitkeeper changesets
Message-ID: <20020904234306.GN761@opus.bloom.county>
References: <20020904141511.GK761@opus.bloom.county> <20020904172646.94693.qmail@web40202.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020904172646.94693.qmail@web40202.mail.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Sep 04, 2002 at 10:26:46AM -0700, Brian Kuschak wrote:

>
> --- Tom Rini <trini@kernel.crashing.org> wrote:
> > Revision numbers are not constant.  BK keys are.
> > 'bk help key2rev'.
> >
>
> So I assume this is the correct way of getting a
> unique, unchanging revision key corresponding to a
> particular ChangeSet:
>
>    bk changes -r1.1091.1.23 -nd:KEY:
>    or
>    bk prs -r1.1091.1.23 -nd:KEY:
>
>    ======== ChangeSet 1.1091.1.23 ========
>    paulus@samba.org|ChangeSet|20020803062658|55132
>
> This changeset removes the -rc5 from EXTRAVERSION in
> the top-level Makefile.  But I can't I convert this
> key back to the revision number:
>
> echo "paulus@samba.org|ChangeSet|20020803062658|55132"
> |bk key2rev Makefile
>
> Can't find
> paulus@samba.org|ChangeSet|20020803062658|55132 in
> SCCS/s.Makefile

You want to do:
echo "paulus@samba.org|ChangeSet|20020803062658|55132" | bk key2rev ChangeSet

It confused me the first time too. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
