Date: Thu, 25 Mar 2004 14:16:29 +0100 (CET)
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: Paul Mackerras <paulus@samba.org>
Cc: Wolfgang Denk <wd@denx.de>, Tolunay Orkun <listmember@orkun.us>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: IBM 440GX, Ocotea...
In-Reply-To: <16482.52384.382130.459316@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.44.0403251414390.25458-100000@linpc003.aimsys.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul,

Much thanks for your explanation, it clarifies a lot.

Jaap-Jan

On Thu, 25 Mar 2004, Paul Mackerras wrote:

>
> Jaap-Jan Boor writes:
>
> > In addition to this nice tree discussion, I've a question:
> > from what 'official ppc' tree do patches eventually get into the
> > official linux kernel tree(s) at kernel.org?
> > only linuxppc-2.4? Or all?
>
> Well, the thing to understand is that there is no automatic,
> effortless way that code goes into the kernel.org trees.  Every change
> that goes in involves somebody putting together a patch against the
> current state of the official kernel.org trees, together with a
> description of what is being changed and why it is being changed, and
> sending that to Marcelo Tosatti, Andrew Morton or Linus Torvalds.
>
> BitKeeper can help to some extent with this, mainly by providing a way
> for us to send Marcelo/Andrew/Linus a bunch of changes in one go.  It
> doesn't, however, provide any automatic way for changes to get from
> the linuxppc-2.4 or linuxppc-2.5 trees into their trees.  The reason
> is that with BK, if you pull the changes from one tree into another
> tree, you have to take all the changes in the first tree that aren't
> in the second.  You can't pick and choose which changesets get
> transferred.  Therefore, we don't ask Marcelo/Andrew/Linus to pull
> from linuxppc-2.[45] into their trees.  There is too much stuff in
> there that isn't ready, or that I don't agree with, or that I just
> don't understand.
>
> I have taken on the role of ppc32 maintainer, part of which involves
> sending changes to Marcelo/Andrew/Linus.  However, doing that involves
> work on my part to identify which changes in linuxppc-2.[45] are ready
> to send, which changes logically go together, and I have to be able to
> explain the change.
>
> When it comes to things like the 8xx/82xx/85xx support, I rely on the
> maintainers for that area -- Tom Rini and Dan Malek -- to do that work
> of identifying sets of related changes that are suitable for inclusion
> in the official trees, and packaging them up with an explanation so
> that they can be sent upstream.  (That can be done either with patches
> or BK changesets; the amount of work required is pretty much the same
> either way.)
>
> Similarly, for the boot code I look to Tom and for the powermac
> support I look to Ben Herrenschmidt.  For the 4xx stuff there isn't
> really a maintainer at the moment, unfortunately, except that Matt
> Porter is looking after the 44x boards.  I look after the classic
> PowerPC core support -- exception handling, memory management, etc.,
> and to some extent the 4xx core support, and the CHRP port.
>
> What this boils down to is that for changes in these areas I expect
> the maintainers for those areas to be packaging up the changes with
> explanations, ready to go upstream.  Anyone is of course welcome to
> put together a patch + explanation and propose that it go upstream.
> In such cases I would ask the maintainer for that area for his
> opinion, or if there isn't a maintainer, I would ask the submitter if
> they will commit to maintaining that area of the code.  If they won't,
> I would tend to drop the patch unless it is a simple, obviously
> correct bugfix.
>
> One problem we have at present is that there are a number of board
> ports which don't appear to have a maintainer.  Sometimes there are
> people using those ports but noone taking responsibility for updating
> it and keeping it working as things change elsewhere in the kernel.
> Having a maintainer is a prerequisite for the board port to be sent
> upstream.
>
> I hope this clarifies things.  If you want the kernel.org trees to
> support your platform, then I suggest you put together the changes you
> want to see as patches and send them to me and the maintainer for the
> subarea.  Make sure that the patch comes with a good explanation of
> the change, and if you think the patch should go upstream, say so.  If
> possible make sure that the patch isn't too large.  If it is large,
> see if you can split it up into smaller patches, each of which
> contains a logically related set of changes.
>
> Regards,
> Paul.
>
>

--
J.G.J. Boor			  Anton Philipsweg 1
Software Engineer		  1223 KZ Hilversum
AimSys bv              		  tel. +31 35 689 1941
Postbus 2194, 1200 CD Hilversum   mailto:jjboor@aimsys.nl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
