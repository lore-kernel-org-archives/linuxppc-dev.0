Message-ID: <3A63C646.DB18CD0@mvista.com>
Date: Mon, 15 Jan 2001 22:55:50 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: frowand@mvista.com
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: kernel mapping
References: <3A63840E.4C724E03@mvista.com> <3A63BAFB.80E3980C@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Frank Rowand wrote:

> I also have the beginnings of simulated BAT mapping for the 405
> (not quite there, but part way).

I know.  I'm currently re-writing it all to be generic.  All of
the 4xx specific pinned entry stuff is gone.  I've been thinking
about this too long for the 8xx and now have a reason to do it.
Some of the logic is in the iopa and mm_ptov functions now, which
will also just work fine on the 6xx/7xx/7xxx.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
