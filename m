Date: Tue, 28 May 2002 16:01:31 -0600
From: Val Henson <val@nmt.edu>
To: "Cameron, Steve" <Steve.Cameron@hp.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: bitkeeper question
Message-ID: <20020528160131.I4721@boardwalk>
References: <45B36A38D959B44CB032DA427A6E10640167CFCE@cceexc18.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45B36A38D959B44CB032DA427A6E10640167CFCE@cceexc18.americas.cpqcorp.net>; from Steve.Cameron@hp.com on Wed, May 15, 2002 at 02:34:54PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 15, 2002 at 02:34:54PM -0500, Cameron, Steve wrote:
>
> Hi,
>
> I'm not sure if this is the right place
> to ask.  I'm wondering about how (and if) tags
> are being used for the bk://ppc.bkserver.net/linuxppc_2_4_devel
> tree.
>
> I would like to be able to clone and
> export a "known" state (lets call it "state_1")
> of the tree, then later be able to get another
> known state of the tree ("state_2") and have
> (or be able to generate) a patch that can take
> me from "state_1" to "state_2".
>
> I guess I can do this by doing
>
> bk export -r state_1 state_1
>
> then, later after some "bk pulls" have been done,
>
> bk export -r state_2 state_2
>
> provided that "state_1" and "state_2" are
> the two tags.
>
> But, i don't know what the tags are that people
> are using, if any.  Or am I grossly misunderstanding
> bitkeeper?  Is it up to me to tag my own clone of
> the repository whenever I want, and just use "bk pull"
> to get "the latest stuff", whatever that might be?
> If there is a regular tagging scheme already in use,
> I think I'd rather just use those existing tags, as
> long as I can stay reasonably up to date that way.
>
> Thanks for any info.

You might be grossly misunderstanding bk, let's see if this makes any
sense...

Every time you do a commit, you've created the equivalent of a CVS
tag.  It's just a number, but it is a "known state" of the entire
repository, not just the files you checked in.  You can add a
non-numeric tag to some versions for convenience, but a non-numeric
tag is not required to do the kind of operations you're looking for.

The easiest way to export a patch is to find the two changeset numbers
you're interested in and run:

bk export -tpatch -r<rev1,rev2> > ../patchfile

Does that help or did I grossly misunderstand you? :)

-VAL

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
