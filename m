Message-ID: <3C6D3ED2.19A93322@mandrakesoft.com>
Date: Fri, 15 Feb 2002 12:01:06 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.5 development
References: <15468.64269.8252.644104@argo.ozlabs.ibm.com> <20020215085812.Z8353@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Larry McVoy wrote:
>
> On Fri, Feb 15, 2002 at 11:11:57PM +1100, Paul Mackerras wrote:
> > The current limitations of BK mean that we will not be able to take
> > changesets directly from the linuxppc-2.5 tree and send them to
> > Linus.
>
> You can export changes as a patch and import them.  Notice that the new
> "bk comments" command will let you change the comments after you do the
> import.  To get a changeset's comments in a form that bk comments will
> like, try this (requires bk 2.1.4 or later):

FWIW, I prefer to export as a patch, and then 'bk citool' to check in.
If you are going to edit the comments anyway, then re-importing a patch
is best done IMHO with

	patch -sp1 -g1 < ~/tmp/patch
	bk citool

--
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
