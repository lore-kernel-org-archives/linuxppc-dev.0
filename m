Date: Mon, 1 Mar 1999 20:08:39 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Keith Clayton <kclayton@jps.net>
cc: /* Vinai */ <vroopcha@post.its.mcw.edu>, linuxppc-user@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: fixes in glibc ??
In-Reply-To: <Pine.LNX.3.96.990227133305.936A-100000@localhost>
Message-ID: <Pine.LNX.4.04.9903012001370.753-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


If one reads the entire liscence on the code with a 'bsd' liscence, there
is a special exception for glibc, allowing it to be covered by the GPL.

Glibc-2.1 has been released, and by the GPL conditions, anyone who
downloaded a copy is free to re-release it. One can get a copy from 

ftp://glibc.cygnus.com/pub/glibc/

Rumor has it the *real* reason it was pulled was that glibc will only
compile with egcs, and was pulled because of lack of support for the 'GNU
C compiler'. This really makes no difference on the PPC, since is no
recent GCC with decent PowerPC support.

> I can't comment on what the current state of glibc 2.0.xxx is but we
> should clarify something for the sake of the Linux/PPC people (Jason, et
> all).  glibc2.1 is not being pulled from r5 alone.  glibc2.1 was
> completely pulled from distrubtion on ANY platform by gnu due to licensing
> problems with one section of code written by people outside gnu.  They
> put a license restriction on their section of code that was a bsd style
> license, which conflicts with the GPL.  As a result GNU pulled glibc2.1
> from their site.  The ability or inability to include glibc2.1 in r5 is
> not a linuxppc.com decision at this point in time.  From posts I've read
> it seems that many have misinterpreted Jason's post to mean that
> linuxppc.com chose not to include glibc2.1.  I'm not privy to their
> decision making process but in this case, glibc2.1 is being pulled by a
> "higher power"  Please no flames as to the assention of RMS to higher
> power status (smile)
> 
> Keith Clayton
> kclayton@jps.net
> 
> 
> On Sat, 27 Feb 1999, /* Vinai */ wrote:
> 
> > 
> > Folks,
> > 
> > I remember a few days ago, there was talk about the latest version of
> > glibc being pulled from R5.  We use an in-house software package that
> > has a plug-in architecture. With the bug in "dlopen", the plug-ins are
> > not accessible ...
> > 
> > Can anyone say whether the R5 version of glibc will have this fix ??
> > 
> > thanx
> > 
> > vinai

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
