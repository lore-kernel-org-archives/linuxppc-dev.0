Message-Id: <200109281754.NAA00839@orchid.cspi.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Brian Waite <bwaite@cspi.com>
Reply-To: bwaite@cspi.com
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.10 stable tree
Date: Fri, 28 Sep 2001 13:44:47 -0400
References: <85256AD5.00541BED.00@pine.cspi.com>
In-Reply-To: <85256AD5.00541BED.00@pine.cspi.com>
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Now I see what must have happenned. Sorry to waste the BW. I must have copied
the simple direcoty from the devel tree into my stable tree and done it
recursively, thus taking the bitkeeper history with it. So I could see all
the changesets with revtool on simple/head.S. I just did a revtool on the
full tree and compared csets with what rev tool on simple head.S showed and
could not match them up. If I only had a brain.
Sorry to waste your time. Thanks Tom for the slap.

On Friday 28 September 2001 11:18 am, you wrote:
> On Fri, Sep 28, 2001 at 11:07:18AM -0400, Brian Waite wrote:
> > I have been working on a stable port of the MVME5100 from the devel tree.
>
> I
>
> > had everything working from 2.4.9 and I got onot other projects. I just
> > grabbed the 2.4.10 stable tree and noticed the arch/ppc/boot/simple
>
> directory
>
> > has been removed. I was using simple/head.S to bring up the board. What
> > should I be using now? Have you abandoned a simple head.S layout and
>
> require
>
> > all baords to have their own head.S now? I am just making sure I am not
> > missing something.
>
> Er.  linuxppc_2_4 (the 'stable' branch) does not have the new boot stuffs
> yet.  I will once things are done however.  Since you're moving the
> mvme5100
> stuff from linuxppc_2_4_devel into linuxppc_2_4 (If I'm reading this
> right),
> just move the arch/ppc/boot/simple stuff as well.

--
Thanks
Brian

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
