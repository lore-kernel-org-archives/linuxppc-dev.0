Message-Id: <5.0.2.1.0.20010216115035.00a57210@pop3.demon.nl>
Date: Fri, 16 Feb 2001 11:53:43 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Erik van Roode <linuxppc@cthulhu.demon.nl>
Subject: Re: Repost: Cannot remove directory `xpti.dat': Operation not
  permitted
In-Reply-To: <3A8CFB2D.310B76CE@ibk.liu.se>
References: <3A8ADFD7.AB3E73B1@ibk.liu.se>
 <20010214183504.A3488@lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:04 AM 2/16/01 +0100, Mats Soderstrom wrote:

>Original message:
>
> >
> > > I was left with this unremoveable directory that supposed to be a
> file after I
> > > had to do a volume repair:
> > >
> > > [root@a22 /]# cd /usr/lib/mozilla/components
> > > [root@a22 components]# ls -l
> > > total 2
> > > dr-s--s-wt   2 14409    25193        2048 Apr 19  2032 xpti.dat
> > > [root@a22 components]# rm -rf *
> > > rm: cannot remove directory `xpti.dat': Operation not permitted
> > > [root@a22 components]#
> > >
> > > How do I remove this file?

The permissions on the xpti.dat directory are irrelevent. It is the permissions
of the directory in which xpti.dat is located that determine whether you are
allowed to delete it. Make sure the permissions of the enclosing directory
include
w permissions. Then ofcourse, with the current permissions of xpti.dat, you are
not allowed to remove anything in it. Use chmod to add w permissions.

Erik


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
