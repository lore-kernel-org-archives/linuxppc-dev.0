Message-ID: <3ABA6D60.46D844F3@mvista.com>
Date: Thu, 22 Mar 2001 16:23:44 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Ralph Blach <rblach@intrex.net>
Cc: frowand@mvista.com, linuxppc-embedded@lists.linuxppc.org,
	David Blythe <blythe@routefree.com>
Subject: Re: Proposed new kernel noncaching memory allocator for the 405gp
References: <3ABA1B6A.87C5FE9B@intrex.net> <3ABA5152.34E4F5B4@mvista.com> <3ABA6746.4BB8DF7@intrex.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph Blach wrote:

> Yes, but these allocate on a page boundry and I was thinking of something a
> little more granular.

You can only control cache behavior on page boundaries at best, and
from the few drivers I have looked at, this is exactly what they
expect.

> Any objections?

I have been listing them in previous messages.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
