Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Tue, 21 Oct 2003 15:36:48 -0700
From: Ron Bianco <ronb@lcsaudio.com>
Subject: RE: Kernel choices for 824x with ext3 FS
In-reply-to: <20031021201042.534DAC59E4@atlas.denx.de>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Message-id: <000701c39823$d04388b0$4d00a8c0@warp-speed>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> >
> > I've been looking at Denx's 2.4.4 port, linuxppc 2.5, linux 2.4.22 and the
> > latest 2.6.0-test trees.
>
> You can also use our linuxppc_2_4_devel tree from CVS (version 2.4.20)

Thanks, I wasn't sure what that module name referred to or the tree's status.
I just did a cvs checkout on it.
I suppose it is a superset of the linux_2_4_devel tree at penguinppc.org?

> > Unfortunately we can't use 2.4.4 as ext3 FS support is not present.
> > FYI, we may also have a need to use RTAI.
>
> We use our linuxppc_2_4_devel tree to validate the PowerPC port of RTAI.

Very cool and helpful.
I see other advantages to 'following the lead' of folks that are much more
kernel savvy, as well.
It's probably best for us to go with that 2.4.20 for now.
Our specific patches for our rather odd ball board should be easier on 2.6.0
later, once I get some experience with 2.4.20.

> I think our 2.4.20 tree is pretty stable; this is one reason we don't
> support more recent versions yet.

Yes that is a major concern.  Unfortunately we still don't have much in the way
of resources to contribute to general kernel debugging or development.  But I
will post what might be of interest as things proceed.

Cheers, Ron


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
