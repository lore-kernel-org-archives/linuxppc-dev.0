Message-ID: <36E08D5D.524D08A8@wanadoo.fr>
Date: Sat, 06 Mar 1999 03:05:17 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Tom Rini <tmrini@ntplx.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: More problem in pre-R5
References: <Pine.LNX.4.05.9903051607040.23617-100000@pc.wackyland.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks for the hint. It is working now. So, if anyone else is listening:
It finally was just this little typo in more.c:

--- util-linux-2.9h/text-utils/more.c   Tue Jan 26 01:09:08 1999
+++ util-linux-2.9i/text-utils/more.c   Thu Jan 28 16:11:00 1999
@@ -1800,7 +1800,7 @@
 
 void errwrite1 (char *sym)
 {
-    write (fileno(stderr), &sym, 1);
+    write (fileno(stderr), sym, 1);
 }
 
 void error (char *mess)

I didn't yet have the courage to compile the whole
util-linux-2.9i.tar.gz, considering that the 2.9h.src.rpm contains
plenty of patches and the 2.9h spec together with the 2.9i.tar.gz didn't
want to build.
Or is there a util-linux-2.9i.src.rpm around?

--
Martin

Tom Rini wrote:
> 
> On Thu, 4 Mar 1999, Tom Rini wrote:
> 
> > On Fri, 5 Mar 1999, Martin Costabel wrote:
> >
> > > Tom Rini wrote:
> > > >
> > > > On Thu, 4 Mar 1999, Martin Costabel wrote:
> > > >
> > > > > Does anyone else see this?
> > > >
> > > > used to. Upgrade ncurses as well.
> > >
> > > Thanks. Just upgraded; still doesn't work. What version of ncurses is
> > > recommended?
> >
> > Gimmie a few.. <g>  I'm looking at a few things now.
> 
> It's been a few, fix found.  For those of you that just can't wait/use
> less, grab util-linux 2.9i and change HAVE_SHADOW=yes to no (current
> behavior) and build.
> 
> ---
> Tom Rini (TR1265)
> http://dobbstown.yeti.edu/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
