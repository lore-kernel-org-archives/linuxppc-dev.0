Message-ID: <B25E2E5A003CD311B61E00902778AF2A02044645@SERVER1>
From: Brian Kuschak <brian.kuschak@skystream.com>
To: "'Dan Malek '" <dan@mvista.com>
Cc: "'Gabriel Paubert '" <paubert@iram.es>,
	"'Eli Chen '" <eli@routefree.com>,
	"'linuxppc-embedded@lists.linuxppc.org '" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: dcache BUG()
Date: Mon, 7 May 2001 20:36:22 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Perhaps it is a filesystem bug, however it's printed when an atomic_read()
of a reference count is unexpectedly zero.  That, plus the fact that I
didn't see it after applying Eli's original patch makes me think we might
still have a problem with atomic operations.

Brian

-----Original Message-----
From: Dan Malek
To: Brian Kuschak
Cc: Gabriel Paubert; Eli Chen; linuxppc-embedded@lists.linuxppc.org
Sent: 5/7/01 7:03 PM
Subject: Re: dcache BUG()

Brian Kuschak wrote:

> ..... but I
> do still see the 'de_put: entry net already free!' messages.

Yuk....I thought that was a network driver problem, but it is really
in the /proc fs stuff.

OK....we'll keep looking.  I still think there are some generic
file system bugs that have been fixed in later kernels....


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
