MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE:  ioremap on powerpc question
Date: Mon, 15 Jul 2002 15:48:30 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E106401281441@cceexc18.americas.cpqcorp.net>
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I wrote:

> I have a question about ioremap_nocache() on powerpc.
[...]
> Now, I see threads on LKML via google that say, essentially,
> "you _must_ use readb/writeb, etc to access addresses returned
> by ioremap,"  [...]
> Using readb/writeb would defeat my purpose.

One more data point.  I tried it with writeb, just to see,
and it blows up just the same anyway, with machine check (bus error).

-- steve

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
