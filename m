MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: bitkeeper question
Date: Wed, 15 May 2002 14:34:54 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E10640167CFCE@cceexc18.americas.cpqcorp.net>
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm not sure if this is the right place
to ask.  I'm wondering about how (and if) tags
are being used for the bk://ppc.bkserver.net/linuxppc_2_4_devel
tree.

I would like to be able to clone and
export a "known" state (lets call it "state_1")
of the tree, then later be able to get another
known state of the tree ("state_2") and have
(or be able to generate) a patch that can take
me from "state_1" to "state_2".

I guess I can do this by doing

bk export -r state_1 state_1

then, later after some "bk pulls" have been done,

bk export -r state_2 state_2

provided that "state_1" and "state_2" are
the two tags.

But, i don't know what the tags are that people
are using, if any.  Or am I grossly misunderstanding
bitkeeper?  Is it up to me to tag my own clone of
the repository whenever I want, and just use "bk pull"
to get "the latest stuff", whatever that might be?
If there is a regular tagging scheme already in use,
I think I'd rather just use those existing tags, as
long as I can stay reasonably up to date that way.

Thanks for any info.

-- steve

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
