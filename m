Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: Andrew Johnson <anj@aps.anl.gov>
Subject: Re: BK to CVS?
Date: Fri, 5 Oct 2001 19:04:44 +0300
References: <20011003130559.F31866@borg.org> <20011005111145.C8157@borg.org> <3BBDD64F.97B0057B@aps.anl.gov>
In-Reply-To: <3BBDD64F.97B0057B@aps.anl.gov>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Message-Id: <01100519044401.01029@scop.digitel.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Andrew

I've ported Linux to a custom 8255-based board and now I'll have to deal with
creating and adapting device drivers for it. I realized that I should start
working with the linuxppc_2_4_devel BK tree, so I can contribute to it.

We internally use CVS nowadays, therefore I'm very interested in your
standard procedures to manage externally developed code.

Thanks in advance,

Ricardo Scop.
Digitel S/A, Brazil

On Friday 05 October 2001 18:48, Andrew Johnson wrote:
> Kent Borg wrote:
> > Then each day I have a script that does:
> > - "bk changes" to see the "before" rev,
> > - "bk pull" to get up to date,
> > - "bk changes" to see "after" rev,
> > - export of a patch between those two revs, apply that to my cvs.
> >
> > The problem is that some of the patches fail because the cvs file
> > isn't in the state the patch expects.  Because I am still getting the
> > bugs out, we aren't doing any work in the cvs tree, only bk stuff is
> > going in there.
>
> Why don't you use the cvs vendor branch to do most of the work for you,
> rather than generating deltas yourself?
>
> Every day you'd get the latest release tree from BK and do a cvs import of
> this into your local repository, followed by the cvs checkout -j -j and
> cvs commit to merge the changes into the main trunk - CVS keeps track of
> the state the BK repository was in when it was last imported.
>
> If you do this right, this should only bring up problems in the checkout
> -j -j stage when some locally committed change conflicts with an imported
> change, which is something you'd have to fix manually anyway.
>
> Oh, and BTW the instructions that cvs import prints out about doing the
> cvs checkout -j -j aren't quite right, you should really use the release
> tags you gave to cvs import rather than the :yesterday it recommends.
>
> I can give more detail on this approach if you're interested - we don't
> import the linuxppc tree, automate it or do it daily, but do have a
> standard procedure for this kind of handling of externally managed code
> with CVS.
>
> - Andrew
> --
> Perfection is reached, not when there is no longer anything to add,
> but when there is no longer anything to take away.
> - Antoine de Saint-Exupery
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
