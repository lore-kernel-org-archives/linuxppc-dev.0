Message-ID: <390DFCD4.1BC8BF8E@embeddededge.com>
Date: Mon, 01 May 2000 17:53:24 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Neil Russell <caret@c-side.com>
CC: Arto Vuori <avuori@ssh.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: 8260 io and caches
References: <390DB320.DC787D62@ssh.com> <20000501101916.E6832@lx.c-side.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Neil Russell wrote:
>
> >From what I can see, the uart driver in the current linux source is written
> for the 860, with no mods for the 8260.

Oh, there are some mods, but I did start with the 8xx code :-).

> ....  The 8260 has some different bits
> in the RFCR/TFCR parameter RAM fields.  There is a GBL bit (bit 2) that
> enables cache snooping.

Oooops.  Sorry about that.  I was playing with caches (and not) and
I guess I didn't get everything checked in properly.  Make sure you
also make the same cache changes to the SCC Ethernet.

Don't consider this software ready to run.  I have more to check
in and I am still making lots of changes.

> .....  Of course, you probably want to add a SMC_GBL
> #define to do this properly.

It was supposed to be there...........


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
