Message-ID: <20000503221141.6962.qmail@web1003.mail.yahoo.com>
Date: Wed, 3 May 2000 15:11:41 -0700 (PDT)
From: Dan Bethe <dan_bethe@yahoo.com>
Subject: Re: hfs
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I'm under the impression that HFS is basically a subset of HFS+, i.e.
> HFS+
> working should fix HFS.  I could easily be wrong, though.

	Well I would guess that it would, but not automatically.  If you go to
an OS that only supports HFS, and you mount an HFS+ filesystem, it will
work but only one file will be available.  It's the magic file entitled
"Where have all my files gone?" or something like that.  So technically
HFS+ is a superset of HFS.  :)
	I guess there are a bunch of people speculating all day rather than
coding it, which is understandable.  Perhaps the primary maintainers of
the most prominent HFS+ and HFS code can surface and let people know
what they're doing, and what they need help on.  Or maybe they'll just
pop up one day and say "Hey we're all done!  Here ya go!"  :^)

=====
"Don't expect your own messiah; this neverworld which you desire is
only in your mind." -- http://www.dreamtheater.net/songb4.htm#IV5


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
