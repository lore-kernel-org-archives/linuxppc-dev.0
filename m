Message-ID: <3A8CFB2D.310B76CE@ibk.liu.se>
Date: Fri, 16 Feb 2001 11:04:29 +0100
From: Mats Soderstrom <mats@ibk.liu.se>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Repost: Cannot remove directory `xpti.dat': Operation not permitted
References: <3A8ADFD7.AB3E73B1@ibk.liu.se> <20010214183504.A3488@lsil.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I posted this earlier asking for help. After a system crash I had to run fsck
manually on several volumes - for me this is saying "yes" to whatever fsck ask if
it should fix. Anyway, after a restart the properties of xpti.dat (a mozilla
component) is changed and I cannot remove it as root. So how do I go about fixing
this? Can I use fsck and specify a sertan file? This is a bit over my head so I
need advice from the experienced guys out there.

Thank you in  advance!

/Mats Soderstrom

Original message:

>
> > I was left with this unremoveable directory that supposed to be a file after I
> > had to do a volume repair:
> >
> > [root@a22 /]# cd /usr/lib/mozilla/components
> > [root@a22 components]# ls -l
> > total 2
> > dr-s--s-wt   2 14409    25193        2048 Apr 19  2032 xpti.dat
> > [root@a22 components]# rm -rf *
> > rm: cannot remove directory `xpti.dat': Operation not permitted
> > [root@a22 components]#
> >
> > How do I remove this file?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
