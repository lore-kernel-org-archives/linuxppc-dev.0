Message-ID: <38423714.D5136535@wanadoo.fr>
Date: Mon, 29 Nov 1999 09:19:32 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Shaw Terwilliger <sterwill@io.nu>
CC: paulus@linuxcare.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.30-pre3
References: <19991128154913.A15762@io.nu> <19991129000645.003441@smtp.calvacom.fr> <19991128221713.A17532@io.nu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Shaw Terwilliger wrote:
> 
> BenH wrote:
> > Yes, please, send me your patches. Paul will be away for a few weeks and
> > I want to move all my patches (there are more coming ;) to 2.3.x asap.
> 
> OK... here they are.  They're against paul's devel tree as of an hour
> ago.  I'm running a fresh-built kernel from a tree with these applied;
> everything's working well.
> 
> Besides being attached here, the individual patches (and the README) are
> available at http://www.abisource.com/~sterwill/patches/.
> 
> If anyone else is interested in bulding the kernel, just grab the
> devel tree and do "patch -p0 < all.patch" from /usr/src (assuming
> the tree is /usr/src/linux).

<???> 
Are there several different versions of Paul's devel tree? The one I am
getting is only at version 2.3.29 and has been nicely compiling and
running for me for a while now. I don't know about chipsfb.c which I am
not using, but the others of your patches are essentially those that A.
Joshi has published a long time ago. And they don't apply to my version
of Paul's devel tree, because they are already built in. 
</???>

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
