Message-ID: <396969E1.A7256E4A@lightning.ch>
Date: Mon, 10 Jul 2000 08:14:57 +0200
From: Daniel Marmier <daniel.marmier@lightning.ch>
Reply-To: daniel.marmier@lightning.ch
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Help with string.S
References: <3967B1E3.80CAC746@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Dan,

IIRC, I have sent you a patch that did the right thing for 16-byte
cache lines at time of 2.3.99-pre5. So this is a known problem and
had already been fixed. Of course, if there are caches with 64 or
128 byte lines, some more work needs to be done.

What gives me trouble is the fact that dcbz instruction in function
arch/ppc/lib/string.S:__copy_tofrom_user does not seem to work for me.
But the function works fine if I remove that instruction. Has anybody
else experienced similar problems ?

Any suggestions welcome,


				Daniel Marmier

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
