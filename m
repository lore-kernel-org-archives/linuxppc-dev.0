Message-ID: <20000706170655.E26935@lx.c-side.com>
Date: Thu, 6 Jul 2000 17:06:55 -0700
From: Neil Russell <caret@c-side.com>
To: ppcboot-internal@lists.sourceforge.net,
        linuxppc-embedded@lists.linuxppc.org
Subject: Licensing of LiMon
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


When I published LiMon, I included a discussion on what my feeling were
about the GPL.  I'm now posting this message to solicit opinions on how
I should proceed with regards licensing of LiMon.

While I firmly believe that public source is a good thing and that GPL
is generally a good thing, I do not think that GPL is appropriate for
LiMon.  This is generally because I what I call the virus clause that
tends to "infect" additions to a piece of GPL software with a GPL license.

In the case of the version of LiMon I am doing for the custom hardware
that the company I'm working for is building, there are parts of the
hardware whose details we wish to remain proprietary and confidential.
This means that parts of the source used to build our version of LiMon,
and the associated ".o" files would not be publicly available, which in
turn means that LiMon could not be rebuilt for our hardware from the
public source.  Since our hardware is not generally useful to the public
in its basic form, I think that this is OK, however, a GPL version of
LiMon would not allow this.

The current public release of LiMon is covered by the GPL, however, the
source that this release was derived from is not.  This means that future
versions of LiMon need not be covered by the GPL.  (Note that at present,
no part of the LiMon public distribution was derived from GPL source).

Some have expressed the desire to be able to add GPL source to LiMon, and
I think that this would be a good thing.

I can think of two solutions:

    1)	LiMon could be distributed under the LGPL (the "Lesser GNU Public
	License"), however, this license was written for libraries, and
	may not be completely appropriate for LiMon.

    2)  LiMon could be changed so that it is a combination of modules that
	are aggregated at run-time.  Some modules could be GPL while
	others are covered under other licenses.  This is how OpenBoot
	(used on SUNs and Apples) is done.

I'm interested in opinions, both technical and legal.


Thanks,
	Neil.


--
Neil Russell <caret@c-side.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
