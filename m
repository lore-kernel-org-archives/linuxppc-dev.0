Date: Sat, 27 Feb 1999 13:39:37 -0800 (PST)
From: Keith Clayton <kclayton@jps.net>
To: /* Vinai */ <vroopcha@post.its.mcw.edu>
cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: fixes in glibc ??
In-Reply-To: <Pine.SOL.3.96.990227004727.16240B-100000@post.its.mcw.edu>
Message-ID: <Pine.LNX.3.96.990227133305.936A-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I can't comment on what the current state of glibc 2.0.xxx is but we
should clarify something for the sake of the Linux/PPC people (Jason, et
all).  glibc2.1 is not being pulled from r5 alone.  glibc2.1 was
completely pulled from distrubtion on ANY platform by gnu due to licensing
problems with one section of code written by people outside gnu.  They
put a license restriction on their section of code that was a bsd style
license, which conflicts with the GPL.  As a result GNU pulled glibc2.1
from their site.  The ability or inability to include glibc2.1 in r5 is
not a linuxppc.com decision at this point in time.  From posts I've read
it seems that many have misinterpreted Jason's post to mean that
linuxppc.com chose not to include glibc2.1.  I'm not privy to their
decision making process but in this case, glibc2.1 is being pulled by a
"higher power"  Please no flames as to the assention of RMS to higher
power status (smile)

Keith Clayton
kclayton@jps.net


On Sat, 27 Feb 1999, /* Vinai */ wrote:

> 
> Folks,
> 
> I remember a few days ago, there was talk about the latest version of
> glibc being pulled from R5.  We use an in-house software package that
> has a plug-in architecture. With the bug in "dlopen", the plug-ins are
> not accessible ...
> 
> Can anyone say whether the R5 version of glibc will have this fix ??
> 
> thanx
> 
> vinai
> 
> 
> 
> 
> 
> [[ This message was sent via the linuxppc-user mailing list. Replies are ]]
> [[ not forced back to the list, so be sure to  Cc linuxppc-user  if your ]]
> [[ reply is of general interest. To unsubscribe from linuxppc-user, send ]]
> [[ the message 'unsubscribe' to linuxppc-user-request@lists.linuxppc.org ]]
> 

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
