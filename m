From: Paul Mackerras <paulus@linuxcare.com>
To: Martin Costabel <costabel@wanadoo.fr>, Shaw Terwilliger <sterwill@io.nu>
Subject: Re: 2.3.30-pre3
Date: Wed, 1 Dec 1999 07:07:06 +1100
Content-Type: text/plain
Cc: linuxppc-dev@lists.linuxppc.org
References: <38423714.D5136535@wanadoo.fr>
MIME-Version: 1.0
Message-Id: <99120107124704.02316@argo.linuxcare.com.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 29 Nov 1999, Martin Costabel wrote:

> Are there several different versions of Paul's devel tree? The one I am
> getting is only at version 2.3.29 and has been nicely compiling and
> running for me for a while now. I don't know about chipsfb.c which I am
> not using, but the others of your patches are essentially those that A.
> Joshi has published a long time ago. And they don't apply to my version
> of Paul's devel tree, because they are already built in. 

This is (partly at least) my fault.  I upgraded to 2.3.30-pre3 (a merge of
my tree and Cort's), found it didn't work, and reverted the devel tree to
2.3.29, which does work just fine for me.

I think that Shaw possibly got a corrupted include/asm-ppc/keyboard.h,
maybe I was updating it as he was fetching it or something.  I have
changed the ifdef in chipsfb.c as Shaw suggested.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
