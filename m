Message-ID: <3AF753F9.6E2839DB@mvista.com>
Date: Mon, 07 May 2001 22:03:37 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Brian Kuschak <brian.kuschak@skystream.com>
Cc: Gabriel Paubert <paubert@iram.es>, Eli Chen <eli@routefree.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
References: <B25E2E5A003CD311B61E00902778AF2A02044644@SERVER1>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian Kuschak wrote:

> ..... but I
> do still see the 'de_put: entry net already free!' messages.

Yuk....I thought that was a network driver problem, but it is really
in the /proc fs stuff.

OK....we'll keep looking.  I still think there are some generic
file system bugs that have been fixed in later kernels....


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
