Date: Thu, 11 Feb 1999 11:40:53 -0800 (PST)
Message-Id: <199902111940.LAA11077@saul9.u.washington.edu>
From: a sun <asun@saul9.u.washington.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: HFS Plus note
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



hi all,

in case you're interested, i've started writing the hfsplus bits. the
header parsing code is pretty much done, and now i'm starting in on
the bitmap allocation code. it turns out that it's ending up to be
pretty unified with the hfs code. i'm just turning all of the
currently hard-coded limits into passed in parameters. it looks like
the only complicated thing beyond running around and doing that will
be the unicode and variable btree key length mods. once that's all
done, i can start using the uid/gid/permissions parts of hfsplus. in
addition, i've also registered 'Lnx0' - 'Lnx9' as the potential
creator types for linux hfsplus volumes.

as a result, mount -t hfs will actually auto-handle hfs and hfsplus
with the option of only seeing the hfs wrapper if you want to do so by
specifying -o hfswrapper.

anyways, one of the things that would be useful for me is some
documentation on linux' nls support. if you know of some, let me
know. otherwise, i'll have to go poking around to see what the other
filesystems do.

-a
asun@u.washington.edu

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
