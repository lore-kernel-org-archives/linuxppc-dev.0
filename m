From: "Matthew Locke" <mlocke@jps.net>
To: "Graham Stoney" <greyham@research.canon.com.au>,
        "Pavel Roskin" <pavel_roskin@geocities.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Download timeout problems on Embedded Planet CLLF (was Patch for zsrec.c)
Date: Mon, 31 Jan 2000 17:13:28 -0800
Message-ID: <NDBBJCEBJMJJJBIMCFBEOEJJCAAA.mlocke@jps.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20000201005642.914451B3E8@elph.research.canon.com.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




> Are other people also having problems with download timeouts on
> Embedded Planet
> boards? (or even if you're not, I'd love to hear what you're
> doing different).

I assume you mean using tftp.  If so ...
I have had the download timeout problems.  It is not related (directly) to
the EP boards.  It is more of a tftp issue.  If there is alot of network
traffic, tftp might not receive its packets in time.  If you have a large
file with alot of network traffic, it defintely will timeout.  I worked
around these issues by isolating the EP and host from the other network
traffic and/or splitting the srec file into smaller parts.

PS: we are working on a ELF binary dnload capabiltiy, watch EPs website next
month.  That will speed up the dnload.


Matthew Locke
Senior Software Engineer
Embedded Planet


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
