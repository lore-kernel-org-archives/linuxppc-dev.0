Date: Fri, 16 Feb 2001 18:46:46 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Mats Soderstrom <mats@ibk.liu.se>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Repost: Cannot remove directory `xpti.dat': Operation not
 permitted
In-Reply-To: <3A8CFB2D.310B76CE@ibk.liu.se>
Message-ID: <Pine.GSO.4.10.10102161845500.11427-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Fri, 16 Feb 2001, Mats Soderstrom wrote:

> > > dr-s--s-wt   2 14409    25193        2048 Apr 19  2032 xpti.dat
> > > [root@a22 components]# rm -rf *
> > > rm: cannot remove directory `xpti.dat': Operation not permitted
> > > [root@a22 components]#
> > >
> > > How do I remove this file?

Did you already try lsattr/chattr?

bye, Roman

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
