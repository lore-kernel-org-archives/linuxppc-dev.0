Date: Fri, 12 Mar 1999 16:53:14 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: linuxppc-dev@lists.linuxppc.org
cc: linuxppc-user@lists.linuxppc.org
Subject: Re: ok, vger anoncvs is back, README (fwd)
In-Reply-To: <Pine.LNX.3.96.990311181502.7624A-100000@persephone.cs.nmt.edu>
Message-ID: <Pine.LNX.4.05.9903121644510.2229-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 11 Mar 1999, Cort Dougan wrote:

> An anoncvs mirror of the vger repositories is available now from
> there.  Sorry for taking so long.  The modules available which people
> should be interested in are 'linux' and 'modutils'.

And for those of you that kept an old vger repository around and don't
mind some ugly for lines:

for i in `find . -name Root`;do echo 
:pserver:anonymous@cvs.on.openprojects.net:/cvs/linux' > $i;done

for i in `find . -name Repository`;do mv $i $i.orig;done
for i in `find . -name Repository.orig`;do echo /cvs/linux/`echo $i | sed
-e 's/\.\///g' -e 's/\/CVS\/Repository.orig//g'` > $i;done

Still have to fix the CVS/Repository at the base of your tree.

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
