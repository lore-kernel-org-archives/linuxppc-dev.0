Message-ID: <3B84150F.4A26D28@mvista.com>
Date: Wed, 22 Aug 2001 16:24:47 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Mark Phillips <thewalthamgroup@netscape.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Text address for 8xx
References: <158A3A7A.7EA3EBDC.C7F6CBA8@netscape.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Phillips wrote:

> Is there a good reason not to make this 400000 for all processors?

Probably fewer than the reasons to keep it at the lower address.
I'll be changing this as part of some generic bootloader changes
over the next week or so.  The reason to use the lower address is
there are still some people that think they can make this run on
a 4MBtye memory.  Another reason is the way the "free" memory is
allocated for the unzip working buffers.  We can fix the latter :-).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
