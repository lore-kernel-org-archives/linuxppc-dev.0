Date: Sun, 12 Sep 1999 16:15:15 -0400
From: brad allison <jackal@aol.net>
To: Multiple recipients of list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: no more processes crash
In-Reply-To: <Pine.SGI.4.00.9908271030280.15912-100000@osiris.office.aol.co
 m>
Message-ID: <Pine.SGI.4.00.9909121607310.611-100000@osiris.office.aol.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I found the bug here.  AIM (tik) tries to play a sound whenever you get an
Instant Message.  I just noticed that sound is not working on my box.

So all these IM sounds got queued up and hung, resulting in a no more
processes error.

Now I'm not sure why sound doesn't work. I have a G3 rev2 B&W running
Shaw's 2.2.6 kernel.

aumix doesn't seem to be working correctly:
[jackal@isis ~]$ aumix -q
vol 216, 88
speaker 216, 88
line 0, 0, P
mic 0, 0, P
cd 0, 0, R
pcm2 15, 0
[jackal@isis ~]$ aumix -v 0 0
[jackal@isis ~]$ aumix -p 0 0
[jackal@isis ~]$ aumix -q
vol 216, 88
speaker 216, 88
line 0, 0, P
mic 0, 0, P
cd 0, 0, R
pcm2 15, 0



On Fri, 27 Aug 1999, brad allison wrote:

> 
> 
> On Fri, 27 Aug 1999, Wulf Hofbauer wrote:
> 
> > > I'm not running much.  Just about 10 aterms, netscape and aim.
> > 
> > Are you using LinuxPPC 1999? The utempter package as distributed by LinuxPPC
> > is broken, xterms for example will never terminate (except by kill -9) and
> > will fill up entries in the process table. I don't know if LinuxPPC has a
> > fix for it (I doubt it), but you'll find the fix at www.redhat.com.
> 
> Anyone know if there's a fix for this?
> 
> I searched on lists.linuxppc.org for utempter and found no mention of this
> problem.
> 
> I found rpm updates for utempter on www.redhat.com for i386, sparc, and
> alpha but not for linuxppc.
> 
> -b

-- 
AOL SAPI    jackal@aol.net    jackal@kmfms.com    703.265.0908   AIM:jackal242 
http://jackal.fudge.org        `I was never more certain of how far away I was 
from my goal than when I was standing right beside it.' - Ethan Hawke, Gattaca

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
